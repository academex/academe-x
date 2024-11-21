import 'dart:io';

abstract class PickState {}

class CreatePostIconsInit extends PickState {}

class CreatePostIconsLoading extends PickState {}

class ImagePickerLoaded extends PickState {
  List<File>? images;
  ImagePickerLoaded(this.images);
}

class FilePickerLoaded extends PickState {
  File? file;
  FilePickerLoaded(this.file);
}

class CreateMultiChoice extends PickState {}

class CreatePostIconsError extends PickState {
  final String message;
  CreatePostIconsError(this.message);
}
