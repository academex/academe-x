import 'dart:io';

import 'package:flutter/material.dart';
enum Status {pickers,multiChoice}
 class PickState {
  final List<File> images;
  final List<File> file;
  final String errorMessage;
  final Status status;
  late final TextEditingController postController;


  PickState({this.images = const [], this.file = const [], this.errorMessage = '',this.status = Status.pickers,TextEditingController? postController}) {
    this.postController = postController??TextEditingController();
  }
  PickState copyWith({
    List<File>? images,
    List<File>? file,
    String? errorMessage,
    Status? status,
    TextEditingController? postController,
  }){
    return PickState(
      images: images??this.images,
      file: file??this.file,
      errorMessage: errorMessage??this.errorMessage,
      status: status??this.status,
      postController:postController??this.postController,
    );
  }
}
