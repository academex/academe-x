import 'package:academe_x/core/core.dart';
import 'package:academe_x/features/college_major/controller/cubit/college_majors_state.dart';
import 'package:academe_x/features/college_major/data/models/major_model.dart';
import 'package:academe_x/features/college_major/domain/entities/major_entity.dart';
import 'package:academe_x/features/college_major/domain/usecases/college_major_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/cache_keys.dart';

class CollegeMajorsCubit extends Cubit<CollegeMajorsState> {
  final CollegeMajorUseCase _collegeMajorsUseCase;

  CollegeMajorsCubit({
    required HiveCacheManager cacheManager,
    required CollegeMajorUseCase getMajorsUseCase,
  }) :
        _collegeMajorsUseCase = getMajorsUseCase,
        super(const CollegeMajorsState());

  void toggleExpanded() {
    AppLogger.success('message');
    emit(state.copyWith(isExpanded: !state.isExpanded));

  }

  void appendMajorToBaseVar(String major) {
    emit(state.copyWith(
        collegeAndMajor: "${state.selectedCollege!} ($major) "
    ));
  }


  Future<void> getColleges() async {
    if (state.isLoadingForCollege) return;
    emit(state.copyWith(isLoadingForCollege: true,errorMessage: null));

    final result = await _collegeMajorsUseCase.getColleges();
    AppLogger.success(result.toString());
    result.fold(
          (failure) {

        List<String>? errorMessage=[];
        if (failure is ValidationFailure) {
          errorMessage = failure.messages;
        } else if (failure is UnauthorizedFailure) {
          errorMessage.add(failure.message);
        } else {
          errorMessage.add(failure.message);
        }
        emit(state.copyWith(
          errorMessage: null,
          isLoadingForCollege: false,
        ));
      },
          (colleges) async {
        emit(state.copyWith(
          status: MajorsStatus.success,
            colleges: colleges,
            isLoadingForCollege: false,
            errorMessage: null

        ));
      },
    );
  }

  void selectIndex({required int? index, }) {
    emit(state.copyWith(selectedMajorIndex: index));
  }

  @override
  void emit(CollegeMajorsState state) {
    AppLogger.success(state.toString());
    super.emit(state);
  }

  Future<void> loadMajors({String? collegeName}) async {
    try {
      emit(state.copyWith(status: MajorsStatus.loading));

      // First try to get cached data
      // final cachedMajors = await _getCachedMajors();
      // if (cachedMajors != null) {
      //   final filteredMajors = collegeName != null
      //       ? cachedMajors.where((major) => major.collegeEn == collegeName).toList()
      //       : cachedMajors;
      //
      //   emit(state.copyWith(
      //     status: MajorsStatus.success,
      //     majors: filteredMajors,
      //     selectedCollege: collegeName,
      //     isCached: true,
      //   ));
      // }

      // Then fetch fresh data
      final result = await _collegeMajorsUseCase.getMajorsByCollege(collegeName!);

      result.fold(
            (failure) {
          // If we have cached data, keep showing it with a warning
          if (state.majors.isNotEmpty) {
            emit(state.copyWith(
              errorMessage: 'Using cached data: ${failure.message}',
              isCached: true,
            ));
          } else {
            emit(state.copyWith(
              status: MajorsStatus.failure,
              errorMessage: failure.message,
            ));
          }
        },
            (majors) async {
          // Cache the new data
          // await _cacheMajors(majors);

          emit(state.copyWith(
            status: MajorsStatus.success,
            majors: majors,
            selectedCollege: collegeName,
            isCached: false,
            errorMessage: null,
          ));
        },
      );
    } catch (e) {
      if (state.majors.isNotEmpty) {
        emit(state.copyWith(
          errorMessage: 'Using cached data: $e',
          isCached: true,
        ));
      } else {
        emit(state.copyWith(
          status: MajorsStatus.failure,
          errorMessage: e.toString(),
        ));
      }
    }
  }

  // Future<List<MajorModel>?> _getCachedMajors() async {
  //   try {
  //     return await _cacheManager.getCachedResponse<List<MajorModel>>(
  //       CacheKeys.MAJORS,
  //           (json) => (json as List)
  //           .map((item) => MajorModel.fromJson(item as Map<String, dynamic>))
  //           .toList(),
  //     );
  //   } catch (e) {
  //     debugPrint('Failed to get majors from cache: $e');
  //     return null;
  //   }
  // }

  // Future<void> _cacheMajors(List<MajorEntity> majors) async {
  //   try {
  //     await _cacheManager.cacheResponse(
  //       CacheKeys.MAJORS,
  //       majors.map((major) => major.entityToModel(major).toJson()).toList(),
  //     );
  //   } catch (e) {
  //     debugPrint('Failed to cache majors: $e');
  //   }
  // }

  Future<void> refreshMajors() async {
    final currentCollegeName = state.selectedCollege;
    await loadMajors(collegeName: currentCollegeName);
  }

  void selectCollege(String college) {
    emit(state.copyWith(selectedCollege: college));
  }

  Future<void> retry()async{
     await getColleges();

  }
}