import 'package:equatable/equatable.dart';
import 'dart:io';
import '../../../../../college_major/domain/entities/major_entity.dart';

enum CreatePostStatus { idle, processing, uploading, success, failure }
enum MediaType { none, images, file, poll }

class CreatePostState extends Equatable {
  // Content
  final String content;
  
  // Media
  final MediaType mediaType;
  final List<File> images;
  final File? document;
  
  // Poll
  final String? pollQuestion;
  final List<String> pollOptions;
  final DateTime? pollEndDate;
  
  // Tags
  final List<MajorEntity> selectedTags;
  final bool showTagSelector;
  
  // Processing
  final CreatePostStatus status;
  final double? uploadProgress;
  final String? errorMessage;
  
  // Image processing
  final bool isProcessingImages;
  final int processedImagesCount;
  final int totalImagesToProcess;

  const CreatePostState({
    this.content = '',
    this.mediaType = MediaType.none,
    this.images = const [],
    this.document,
    this.pollQuestion,
    this.pollOptions = const ['', ''],
    this.pollEndDate,
    this.selectedTags = const [],
    this.showTagSelector = false,
    this.status = CreatePostStatus.idle,
    this.uploadProgress,
    this.errorMessage,
    this.isProcessingImages = false,
    this.processedImagesCount = 0,
    this.totalImagesToProcess = 0,
  });

  // Computed properties
  bool get hasContent => content.trim().isNotEmpty;
  bool get hasMedia => images.isNotEmpty || document != null || isPollValid;
  bool get canSubmit => hasContent && status != CreatePostStatus.processing;
  
  bool get isPollValid {
    if (pollQuestion == null || pollQuestion!.trim().isEmpty) return false;
    final validOptions = pollOptions.where((opt) => opt.trim().isNotEmpty).length;
    return validOptions >= 2;
  }

  CreatePostState copyWith({
    String? content,
    MediaType? mediaType,
    List<File>? images,
    File? document,
    String? pollQuestion,
    List<String>? pollOptions,
    DateTime? pollEndDate,
    List<MajorEntity>? selectedTags,
    bool? showTagSelector,
    CreatePostStatus? status,
    double? uploadProgress,
    String? errorMessage,
    bool? isProcessingImages,
    int? processedImagesCount,
    int? totalImagesToProcess,
  }) {
    return CreatePostState(
      content: content ?? this.content,
      mediaType: mediaType ?? this.mediaType,
      images: images ?? this.images,
      document: document ?? this.document,
      pollQuestion: pollQuestion ?? this.pollQuestion,
      pollOptions: pollOptions ?? this.pollOptions,
      pollEndDate: pollEndDate ?? this.pollEndDate,
      selectedTags: selectedTags ?? this.selectedTags,
      showTagSelector: showTagSelector ?? this.showTagSelector,
      status: status ?? this.status,
      uploadProgress: uploadProgress,
      errorMessage: errorMessage,
      isProcessingImages: isProcessingImages ?? this.isProcessingImages,
      processedImagesCount: processedImagesCount ?? this.processedImagesCount,
      totalImagesToProcess: totalImagesToProcess ?? this.totalImagesToProcess,
    );
  }
  
  // Helper to clear media
  CreatePostState clearMedia() {
    return copyWith(
      mediaType: MediaType.none,
      images: [],
      document: null,
      pollQuestion: null,
      pollOptions: ['', ''],
      pollEndDate: null,
    );
  }
  
  // Helper to reset state
  CreatePostState reset() {
    return const CreatePostState();
  }

  @override
  List<Object?> get props => [
        content,
        mediaType,
        images,
        document,
        pollQuestion,
        pollOptions,
        pollEndDate,
        selectedTags,
        showTagSelector,
        status,
        uploadProgress,
        errorMessage,
        isProcessingImages,
        processedImagesCount,
        totalImagesToProcess,
      ];
}