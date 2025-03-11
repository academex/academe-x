import 'dart:io';
import 'dart:typed_data';

import 'package:academe_x/academeX_main.dart';
import 'package:academe_x/lib.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:logger/logger.dart';

class PickerCubit extends Cubit<PickState> {
  PickerCubit(super.initialState);
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> pickImage(BuildContext context) async {
    if (state.images.isNotEmpty) {
      emit(state.copyWith(images: []));
      return;
    }
    showDialog(
      context: context, // Prevent dismissing by tapping outside
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: AppText(
            text:
                'جار معالجة الصور،\nهذا يعتمد على حجم الصور التي قمت برفعها\nوسرعة معالج هاتقك...\nوهذا لا يعتمد أبدا على سرعة الانترنت...',
            fontSize: 12.sp,
          ),
        );
      },
    );
    final List<XFile>? pickedFile = await _imagePicker.pickMultiImage(limit: 5);

    if (pickedFile != null) {
      final List<File> resizedImages = [];

      // Use Future.wait to process images concurrently
      final List<Future<void>> resizeFutures =
          pickedFile.map((XFile image) async {
        final File imageFile = File(image.path);
        final Uint8List imageBytes = await imageFile.readAsBytes();
        final img.Image? decodedImage = img.decodeImage(imageBytes);

        if (decodedImage != null) {
          int quality = 100; // Start with maximum quality

          List<int> compressedImageBytes =
              img.encodeJpg(decodedImage, quality: quality);
          // emit(state.copyWith(
          //   statusResize: StatusResize.loading,
          //   bytes: compressedImageBytes.length.toDouble(),
          // ));
          while (compressedImageBytes.length > 100 * 1024 && quality > 10) {
            Logger().d(
                'Compressing image with quality: ${compressedImageBytes.length / 1024}');
            quality -= (quality > 30)
                ? 10
                : 5; // Larger decrement for higher qualities
            compressedImageBytes.length > 1024 * 1024 ? quality -= 50 : quality;
            compressedImageBytes =
                img.encodeJpg(decodedImage, quality: quality);
            emit(state.copyWith(
              bytes: compressedImageBytes.length.toDouble(),
            ));
          }

          // emit(state.copyWith(
          //   statusResize: StatusResize.success,
          //   bytes: 0,
          // ));

          // Save the compressed image to a temporary file
          final File resizedImageFile = File(
              '${imageFile.parent.path}/resized_${imageFile.uri.pathSegments.last}');
          await resizedImageFile.writeAsBytes(compressedImageBytes);

          // Add the resized image to the list
          resizedImages.add(resizedImageFile);
        }
      }).toList();

      // Wait for all resizing to complete
      await Future.wait(resizeFutures);

      // Update the state with the resized images
      emit(state.copyWith(images: resizedImages));
    } else {
      // No file selected
      print('No images selected.');
    }
    Navigator.pop(context);
  }

  init() async {
    state.postController.clear();
    emit(PickState());
  }

  pickFile() async {
    if (state.file.isNotEmpty) {
      emit(state.copyWith(file: []));
      return;
    }

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowCompression: true,
    );

    if (result != null) {
      emit(state.copyWith(file: [File(result.files.single.path!)]));
    } else {
      // no file selected
    }
  }
  removeImageAt(int index){
    state.images.removeAt(index);
    emit(state.copyWith(images: state.images));
  }
  removeFile(){
    state.file.clear();
    emit(state.copyWith(file: state.file));
  }

  createMultiChoice() {
    if (state.status == Status.multiChoice) {
      emit(state.copyWith(status: Status.pickers));
      return;
    }
    emit(state.copyWith(status: Status.multiChoice));
  }
}
