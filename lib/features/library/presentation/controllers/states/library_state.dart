import 'package:equatable/equatable.dart';
import 'package:academe_x/features/home/domain/entities/post/post_entity.dart';
import 'package:academe_x/features/auth/auth.dart';

import '../../../domain/entities/library_entity.dart';

enum LibraryStatus { initial, loading, loaded, error }

class LibraryState extends Equatable {
  // Profile data
  final LibraryStatus status;
  final String? errorMessage;

  // User posts
  final Map<String?, List<LibraryEntity>> libraryFiles;
  final List<LibraryEntity> files;
  final bool isStared;
  final int currentPage;

  const LibraryState({
    this.status = LibraryStatus.initial,
    this.errorMessage,
    this.libraryFiles = const {},
    this.files = const [],
    this.isStared = false,
    this.currentPage = 1,
  });

  LibraryState copyWith({
    LibraryStatus? status,
    String? errorMessage,
    bool? isLoading,
    Map<String?, List<LibraryEntity>>? libraryFiles,
     List<LibraryEntity>? files,

    bool? isStared,
    int? currentPage,
  }) {
    return LibraryState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      libraryFiles: libraryFiles ?? this.libraryFiles,
      files: files ?? this.files,
      isStared: isStared ?? this.isStared,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    libraryFiles,
    files,
    isStared,
    currentPage,
  ];
}