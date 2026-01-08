import 'dart:io';
import 'dart:isolate';
import 'package:academe_x/features/home/domain/entities/post/file_info_entity.dart';
import 'package:academe_x/features/home/domain/entities/post/image_entity.dart';
import 'package:academe_x/features/home/domain/entities/post/poll/poll.dart';
import 'package:academe_x/features/home/domain/entities/post/poll/poll_option.dart';
import 'package:academe_x/features/home/domain/usecases/post_use_case.dart';
import 'package:academe_x/features/home/presentation/controllers/states/create_post/create_post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image/image.dart' as img;
import '../../../../../college_major/domain/entities/major_entity.dart';
import '../../../../domain/entities/post/post_entity.dart';
import '../../../../../../core/utils/logger.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  final PostUseCase postUseCase;
  final ImagePicker _imagePicker = ImagePicker();

  CreatePostCubit({required this.postUseCase}) : super(const CreatePostState());

  // ========== CONTENT ==========
  
  void updateContent(String content) {
    emit(state.copyWith(content: content));
  }

  // ========== MEDIA ==========
  
  /// Pick and process images in background isolate
  Future<void> pickImages() async {
    if (state.images.isNotEmpty) {
      // Clear existing images
      emit(state.copyWith(
        images: [],
        mediaType: MediaType.none,
      ));
      return;
    }

    try {
      final List<XFile>? pickedFiles = await _imagePicker.pickMultiImage(
        limit: 5,
      );

      if (pickedFiles == null || pickedFiles.isEmpty) return;

      emit(state.copyWith(
        isProcessingImages: true,
        totalImagesToProcess: pickedFiles.length,
        processedImagesCount: 0,
      ));

      final List<File> processedImages = [];

      // Process images one by one with progress updates
      for (int i = 0; i < pickedFiles.length; i++) {
        final processedImage = await _processImageInBackground(
          File(pickedFiles[i].path),
        );
        
        processedImages.add(processedImage);
        
        emit(state.copyWith(
          processedImagesCount: i + 1,
        ));
      }

      emit(state.copyWith(
        images: processedImages,
        mediaType: MediaType.images,
        isProcessingImages: false,
        processedImagesCount: 0,
        totalImagesToProcess: 0,
      ));
    } catch (e) {
      AppLogger.e('Error picking images: $e');
      emit(state.copyWith(
        isProcessingImages: false,
        errorMessage: 'فشل في معالجة الصور',
      ));
    }
  }

  /// Process image in background isolate to avoid blocking UI
  Future<File> _processImageInBackground(File imageFile) async {
    final receivePort = ReceivePort();
    
    await Isolate.spawn(
      _compressImageIsolate,
      _ImageProcessingMessage(
        imagePath: imageFile.path,
        sendPort: receivePort.sendPort,
      ),
    );

    final compressedPath = await receivePort.first as String;
    return File(compressedPath);
  }

  /// Isolate function for image compression
  static void _compressImageIsolate(_ImageProcessingMessage message) async {
    try {
      final imageFile = File(message.imagePath);
      final imageBytes = await imageFile.readAsBytes();
      final decodedImage = img.decodeImage(imageBytes);

      if (decodedImage != null) {
        int quality = 85; // Start with good quality
        List<int> compressedBytes = img.encodeJpg(decodedImage, quality: quality);

        // Target: < 500KB
        while (compressedBytes.length > 500 * 1024 && quality > 20) {
          quality -= 5;
          compressedBytes = img.encodeJpg(decodedImage, quality: quality);
        }

        // Save compressed image
        final outputPath = '${imageFile.parent.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg';
        final outputFile = File(outputPath);
        await outputFile.writeAsBytes(compressedBytes);

        message.sendPort.send(outputPath);
      }
    } catch (e) {
      message.sendPort.send(message.imagePath); // Return original on error
    }
  }

  void removeImage(int index) {
    final updatedImages = List<File>.from(state.images);
    updatedImages.removeAt(index);
    
    emit(state.copyWith(
      images: updatedImages,
      mediaType: updatedImages.isEmpty ? MediaType.none : MediaType.images,
    ));
  }

  /// Pick document (PDF)
  Future<void> pickDocument() async {
    if (state.document != null) {
      emit(state.copyWith(
        document: null,
        mediaType: MediaType.none,
      ));
      return;
    }

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowCompression: true,
      );

      if (result != null && result.files.single.path != null) {
        emit(state.copyWith(
          document: File(result.files.single.path!),
          mediaType: MediaType.file,
        ));
      }
    } catch (e) {
      AppLogger.e('Error picking document: $e');
      emit(state.copyWith(
        errorMessage: 'فشل في اختيار الملف',
      ));
    }
  }

  // ========== POLL ==========
  
  void togglePollMode() {
    if (state.mediaType == MediaType.poll) {
      emit(state.copyWith(
        mediaType: MediaType.none,
        pollQuestion: null,
        pollOptions: ['', ''],
        pollEndDate: null,
      ));
    } else {
      emit(state.copyWith(
        mediaType: MediaType.poll,
        pollEndDate: DateTime.now().add(const Duration(days: 7)),
      ));
    }
  }

  void updatePollQuestion(String question) {
    emit(state.copyWith(pollQuestion: question));
  }

  void updatePollOption(int index, String value) {
    final updatedOptions = List<String>.from(state.pollOptions);
    
    if (index < updatedOptions.length) {
      updatedOptions[index] = value;
    } else {
      updatedOptions.add(value);
    }
    
    emit(state.copyWith(pollOptions: updatedOptions));
  }

  void addPollOption() {
    if (state.pollOptions.length < 10) {
      emit(state.copyWith(
        pollOptions: [...state.pollOptions, ''],
      ));
    }
  }

  void removePollOption(int index) {
    if (state.pollOptions.length > 2) {
      final updatedOptions = List<String>.from(state.pollOptions);
      updatedOptions.removeAt(index);
      emit(state.copyWith(pollOptions: updatedOptions));
    }
  }

  void updatePollEndDate(DateTime date, TimeOfDay? time) {
    DateTime endDate;
    if (time != null) {
      endDate = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    } else {
      endDate = date;
    }
    
    emit(state.copyWith(pollEndDate: endDate));
  }

  // ========== TAGS ==========
  
  void toggleTagSelector() {
    emit(state.copyWith(showTagSelector: !state.showTagSelector));
  }

  void initializeDefaultTag(MajorEntity tag) {
    if (state.selectedTags.isEmpty) {
      emit(state.copyWith(selectedTags: [tag]));
    }
  }

  void toggleTag(MajorEntity tag) {
    final updatedTags = List<MajorEntity>.from(state.selectedTags);
    
    if (updatedTags.any((t) => t.id == tag.id)) {
      updatedTags.removeWhere((t) => t.id == tag.id);
    } else {
      updatedTags.add(tag);
    }
    
    emit(state.copyWith(selectedTags: updatedTags));
  }

  // ========== SUBMIT ==========
  
  Future<void> submitPost(BuildContext context) async {
    if (!state.canSubmit) return;

    // Validate poll if present
    if (state.mediaType == MediaType.poll && !state.isPollValid) {
      emit(state.copyWith(
        errorMessage: 'يرجى إضافة سؤال وخيارين على الأقل للتصويت',
      ));
      return;
    }

    try {
      emit(state.copyWith(status: CreatePostStatus.uploading));

      // Build post entity
      final post = PostEntity(
        content: state.content,
        tags: state.selectedTags,
        images: state.images.map((file) => ImageEntity(
          id: 0,
          url: file.path,
        )).toList(),
        file: state.document != null 
            ? FileInfo(url: state.document!.path)
            : null,
        poll: state.mediaType == MediaType.poll && state.isPollValid
            ? Poll(
                id: 0,
                question: state.pollQuestion!,
                pollOptions: state.pollOptions
                    .where((opt) => opt.trim().isNotEmpty)
                    .toList()
                    .asMap()
                    .entries
                    .map((entry) => PollOption(
                          id: entry.key,
                          content: entry.value,
                          order: entry.key,
                          count: 0,
                          isVoted: false,
                        ))
                    .toList(),
                totalVotes: 0,
              )
            : null,
      );

      // Submit to use case
      final result = await postUseCase.createPost(post, context);

      result.fold(
        (failure) {
          emit(state.copyWith(
            status: CreatePostStatus.failure,
            errorMessage: failure.message,
          ));
        },
        (createdPost) {
          emit(state.copyWith(
            status: CreatePostStatus.success,
          ));
        },
      );
    } catch (e) {
      AppLogger.e('Error submitting post: $e');
      emit(state.copyWith(
        status: CreatePostStatus.failure,
        errorMessage: 'فشل في إنشاء المنشور',
      ));
    }
  }

  // ========== UTILITY ==========
  
  void reset() {
    emit(const CreatePostState());
  }

  void clearError() {
    emit(state.copyWith(errorMessage: null));
  }
}

// Helper class for isolate communication
class _ImageProcessingMessage {
  final String imagePath;
  final SendPort sendPort;

  _ImageProcessingMessage({
    required this.imagePath,
    required this.sendPort,
  });
}