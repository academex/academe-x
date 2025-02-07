import 'dart:io';

import 'package:flutter/material.dart';
enum Status {pickers,multiChoice}
enum StatusResize { init, loading, success }

class PickState {
  final List<File> images;
  final List<File> file;
  final String errorMessage;
  final Status status;
  final StatusResize statusResize;
  final double bytes;
  late final TextEditingController postController;

  PickState({
    this.images = const [],
    this.file = const [],
    this.errorMessage = '',
    this.status = Status.pickers,
    this.statusResize = StatusResize.init,
    this.bytes = 0,
    TextEditingController? postController,
  }) {
    this.postController = postController??TextEditingController();
  }
  PickState copyWith({
    List<File>? images,
    List<File>? file,
    String? errorMessage,
    Status? status,
    TextEditingController? postController,
    StatusResize? statusResize,
    double? bytes,
  }){
    return PickState(
      images: images??this.images,
      file: file??this.file,
      errorMessage: errorMessage??this.errorMessage,
      status: status??this.status,
      postController:postController??this.postController,
      statusResize:statusResize??this.statusResize,
      bytes:bytes??this.bytes,
    );
  }
}
