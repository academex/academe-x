import 'package:academe_x/core/core.dart';
import 'package:academe_x/core/error/failure.dart';
import 'package:academe_x/features/profile/domain/usecases/profile_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../../../core/pagination/paginated_response.dart';
import '../../../../../core/pagination/pagination_params.dart';
import '../../../../home/domain/entities/post/post_entity.dart';
import '../../../domain/entities/library_entity.dart';
import '../../../domain/usecases/library_usecase.dart';
import '../states/library_state.dart';

class LibraryCubit extends Cubit<LibraryState> {
  final LibraryUseCase libraryUseCase;

  final ScrollController scrollController = ScrollController();
  bool _isLoading = false;

  LibraryCubit({
    required this.libraryUseCase,
  }) : super(const LibraryState());



  Future<void> loadLibrary() async {
    final Either<Failure, PaginatedResponse<LibraryEntity>> result;
    if (_isLoading) return;
    // if (state.hasPostsReachedMax) return;

    try {
      emit(state.copyWith(status: LibraryStatus.loading));
      _isLoading = true;
      // final page = state.currentPage;
      result = await libraryUseCase.loadLibrary(
  const PaginationParams(page: 1,),
  );
      result.fold(
        (failure) {
          emit(state.copyWith(
            status: LibraryStatus.error,
            errorMessage: failure.message,
          ));
        },
        (paginatedData) => _handleSuccessResponse(paginatedData),
      );
    } catch (e) {
      emit(state.copyWith(
        status: LibraryStatus.error,
        errorMessage: e.toString(),
      ));
    } finally {
      _isLoading = false;
    }
  }

  void _handleSuccessResponse(
    PaginatedResponse<LibraryEntity> paginatedData,
  ) {
    final List<LibraryEntity> newFiles = [...state.files];
    for (var newFile in paginatedData.items) {
      if (!newFiles.any((existingFile) => existingFile.id == newFile.id)) {
        newFiles.add(newFile);
      }
    }

    final groupFilesByType={
      for(var file in newFiles)
        file.type: newFiles.where((element) => element.type == file.type).toList()
    };



    emit(state.copyWith(
      status: LibraryStatus.loaded,
      libraryFiles: groupFilesByType,
      files: newFiles,
      hasLibraryReachedMax:  !paginatedData.hasNextPage,
      currentPage: state.currentPage + 1,
      errorMessage: null,
    ));
  }

  bool isAtTop() {
    return scrollController.position.pixels <= 0;
  }

  void goToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }
}
