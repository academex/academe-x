import 'dart:io';

import 'package:academe_x/lib.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class PickerCubit extends Cubit<PickState> {
  PickerCubit(super.initialState);
  final ImagePicker _imagePicker = ImagePicker();


  pickImage() async {
    if (state.images.isNotEmpty) {
      emit(state.copyWith(images: []));
      return;
    }
    final List<XFile>? pickedFile = await _imagePicker.pickMultiImage();
    if (pickedFile != null) {
      emit(state.copyWith(images: pickedFile.map((image) => File(image.path)).toList()));
    } else {
      // no file selected
    }
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
