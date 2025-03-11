import 'package:academe_x/core/core.dart';
import 'package:academe_x/core/error/failure.dart';
import 'package:academe_x/core/utils/extensions/cached_user_extension.dart';
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



  Future<void> loadLibrary({required BuildContext context,int? yearNum,int? tagId}) async {
    final Either<Failure, List<LibraryEntity>> result;
    if (_isLoading) return;
    try {
      emit(state.copyWith(status: LibraryStatus.loading));

      if(yearNum==null && tagId==null){
        final userCached= await context.cachedUser;
        int tagId= userCached!.user.tagId!;
        int currentYearNum= userCached.user.currentYear!;
        result = await libraryUseCase.loadLibrary(
          PaginationParams(tagId: tagId,yearNum: currentYearNum),
        );
      }else{
        result = await libraryUseCase.loadLibrary(
          PaginationParams(tagId: tagId,yearNum: yearNum),
        );
      }

      _isLoading = true;
      result.fold(
        (failure) {
          emit(state.copyWith(
            status: LibraryStatus.error,
            errorMessage: failure.message,
          ));
        },
        (files) => _handleSuccessResponse(files),
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
      List<LibraryEntity> newData,
  ) {
    // final List<LibraryEntity> newFiles = [...state.files];
    // for (var newFile in newData) {
    //   if (!newFiles.any((existingFile) => existingFile.id == newFile.id)) {
    //     newFiles.add(newFile);
    //   }
    // }

    final groupFilesByType={
      for(var file in newData)
        file.type: newData.where((element) => element.type == file.type).toList()
    };

    emit(state.copyWith(
      status: LibraryStatus.loaded,
      libraryFiles: groupFilesByType,
      files: newData,
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
