import 'package:academe_x/features/library/domain/entities/library_entity.dart';
import 'package:equatable/equatable.dart';

enum FileUploadStatus { initial, picking, uploading, success, failure }

class FileUploadState extends Equatable {
  final FileUploadStatus status;
  final LibraryEntity? file;
  final double progress;
  final String? errorMessage;
  final String? uploadedFileUrl;
  final List<String> typesOfFiles;
  final int? selectedIndex;

  const FileUploadState({
    this.status = FileUploadStatus.initial,
    this.file,
    this.progress = 0.0,
    this.errorMessage,
    this.uploadedFileUrl,
    this.selectedIndex,
    this.typesOfFiles=const[
      'BOOK',
      'CHAPTER',
      'SUMMARY',
      'EXAM',
  ],
  });

  FileUploadState copyWith({
    FileUploadStatus? status,
    LibraryEntity? file,
    double? progress,
    String? errorMessage,
    String? uploadedFileUrl,
    int? selectedIndex,
  }) {
    return FileUploadState(
      status: status ?? this.status,
      file: file ?? this.file,
      progress: progress ?? this.progress,
      errorMessage: errorMessage ?? this.errorMessage,
      uploadedFileUrl: uploadedFileUrl ?? this.uploadedFileUrl,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object?> get props => [status, file, progress, errorMessage, uploadedFileUrl,selectedIndex];
}