import 'package:academe_x/core/core.dart';
import 'package:academe_x/core/utils/extensions/cached_user_extension.dart';
import 'package:academe_x/features/college_major/controller/cubit/college_majors_state.dart';
import 'package:academe_x/features/college_major/domain/entities/major_entity.dart';
import 'package:academe_x/features/college_major/domain/usecases/college_major_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../academeX_main.dart';
import '../../../auth/domain/entities/response/auth_token_entity.dart';


class CollegeMajorsCubit extends Cubit<CollegeMajorsState> {
  final CollegeMajorUseCase _collegeMajorsUseCase;
  late  AuthTokenEntity? _authTokenEntity;
  late  MajorEntity? _majorEntity;

  CollegeMajorsCubit({
    required HiveCacheManager cacheManager,
    required CollegeMajorUseCase getMajorsUseCase,
  }) :
        _collegeMajorsUseCase = getMajorsUseCase,
        super( CollegeMajorsState());

  void toggleVisibleMajors(){
    // AppLogger.success('message');
    emit(state.copyWith(isVisibileMajors: !state.isVisibileMajors));

  }

  Future<void> initCollegeMajor()async{
    await getColleges();
    await getTags();
    await getCachedUser();
    await getMajorSetting();
  }

  Future<void> getCachedUser()async{
    _authTokenEntity= (await NavigationService.navigatorKey.currentContext!.cachedUser);
  }

  Future<void> getMajorSetting() async {
    try {
      if (_authTokenEntity != null && state.majors.isNotEmpty) {
        _majorEntity = state.majors.firstWhere(
              (element) => _authTokenEntity!.user.tagId == element.id,
        );
        selectTag(_majorEntity!);
      }
      emit(state.copyWith(isLoadingMajorSetting: false));
    } catch (e) {
      emit(state.copyWith(
        isLoadingMajorSetting: false,
        errorMessage: 'Failed to load major settings',
      ));
    }
  }

  void toggleExpanded() {
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
    super.emit(state);
  }

  Future<void> loadMajors({String? collegeName}) async {
    try {
      emit(state.copyWith(status: MajorsStatus.loading));


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

  getTags() async {
    emit(state.copyWith(
        status: MajorsStatus.loading
    ));
    var createPostRes = await _collegeMajorsUseCase.getTags();
    createPostRes.fold(
          (l) {
        emit(state.copyWith(status: MajorsStatus.failure,
            errorMessage: l.message));
      },
          (r) {
        emit(state.copyWith(status: MajorsStatus.success,
            majors: r));
      },
    );
  }

  Future<void> selectTag(MajorEntity major) async{

    emit(state.copyWith(selectedTag: major.name,selectedMajor: major));
  }
}