import 'dart:io';

import 'package:academe_x/lib.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class PickerCubit extends Cubit<CreatePostIconsState> {
  PickerCubit(super.initialState);
  final ImagePicker _imagePicker = ImagePicker();

  pickImage() async {
    emit(CreatePostIconsLoading());

    final List<XFile>? pickedFile = await _imagePicker.pickMultiImage();
    if (pickedFile != null) {
      emit(ImagePickerLoaded(
          pickedFile.map((image) => File(image.path)).toList()));
    } else {
      emit(CreatePOstIconsError('no file selected'));
    }
  }

  pickFile() async {
    emit(CreatePostIconsLoading());

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowCompression: true,
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      emit(FilePickerLoaded(file));
    } else {
      emit(CreatePOstIconsError('no file selected'));
    }
  }
  createMulteChoice(){
    emit(CreateMultiChoice());
  }
}
