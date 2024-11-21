import 'dart:io';

import 'package:academe_x/lib.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class PickerCubit extends Cubit<PickState> {
  PickerCubit(super.initialState);
  final ImagePicker _imagePicker = ImagePicker();

  cancelState() {
    emit(CreatePostIconsInit());
  }

  pickImage() async {
    if (getIt<ImagePickerLoaded>().images != null) {
      getIt<ImagePickerLoaded>().images = null;
      cancelState();
      emit(getIt<ImagePickerLoaded>());
      return;
    }
    emit(CreatePostIconsLoading());

    final List<XFile>? pickedFile = await _imagePicker.pickMultiImage();
    if (pickedFile != null) {
      getIt<ImagePickerLoaded>().images =
          pickedFile.map((image) => File(image.path)).toList();
      emit(getIt<ImagePickerLoaded>());
    } else {
      emit(CreatePostIconsError('no file selected'));
    }
  }

  pickFile() async {
    if (getIt<FilePickerLoaded>().file != null) {
      getIt<FilePickerLoaded>().file = null;
      cancelState();
      emit(getIt<FilePickerLoaded>());
      return;
    }
    emit(CreatePostIconsLoading());

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowCompression: true,
    );

    if (result != null) {
      getIt<FilePickerLoaded>().file = File(result.files.single.path!);
      emit(getIt<FilePickerLoaded>());
    } else {
      emit(CreatePostIconsError('no file selected'));
    }
  }

  createMultiChoice() {
    if (state is CreateMultiChoice) {
      cancelState();
      return;
    }
    emit(CreateMultiChoice());
  }
}
