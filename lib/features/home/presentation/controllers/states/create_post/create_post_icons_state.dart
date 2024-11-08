import 'dart:io';

abstract class CreatePostIconsState{}

class CreatePostIconsInit extends CreatePostIconsState {}

class CreatePostIconsLoading extends CreatePostIconsState {}

class ImagePickerLoaded extends CreatePostIconsState {
  final List<File> images;
  ImagePickerLoaded(this.images);
}
class FilePickerLoaded extends CreatePostIconsState {
  final File file;
  FilePickerLoaded(this.file);
}
class CreateMultiChoice extends CreatePostIconsState {}
  
class CreatePOstIconsError extends CreatePostIconsState {
  final String message;
  CreatePOstIconsError(this.message);
}


