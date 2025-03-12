import 'package:academe_x/core/core.dart';
import 'package:academe_x/features/auth/auth.dart';
import 'package:academe_x/features/library/domain/entities/file_entity.dart';
import 'package:academe_x/features/library/domain/usecases/library_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../auth/presentation/controllers/cubits/signup_cubit.dart';
import '../states/file_upload_state.dart';

class FileUploadCubit extends Cubit<FileUploadState> {
  final LibraryUseCase pickFileUseCase;

  FileUploadCubit({
    required this.pickFileUseCase,
  }) : super(const FileUploadState());

  Future<void> pickFile() async {
    emit(state.copyWith(status: FileUploadStatus.picking));

    final result = await pickFileUseCase.pickFile();

    result.fold(
          (failure) => emit(state.copyWith(
        status: FileUploadStatus.failure,
        errorMessage: failure.message,
      )),
          (file) => emit(state.copyWith(
        status: FileUploadStatus.initial,
        file: file,
      )),
    );
  }

  Future<void> uploadFile(FileEntity fileInfo,BuildContext context) async {
    if (state.file == null) {
      emit(state.copyWith(
        status: FileUploadStatus.failure,
        errorMessage: 'No file selected',
      ));
      return;
    }

    emit(state.copyWith(
      status: FileUploadStatus.uploading,
      progress: 0.0,
    ));
    // int? tagId= context.read<SignupCubit>().state.selectedTagId;
    // int? yearNum= context.read<SignupCubit>().state.selectedSemesterIndex!+1;
    // state.file!.yearNum=yearNum;
    // state.file!.tags=[
    //   MajorEntity()
    // ];


    final result = await pickFileUseCase.uploadFile(fileInfo,state.file!, (progress) async{

      // AppLogger.success(progress.toString());
          emit(state.copyWith(progress: progress));
        });

    result.fold(
          (failure) => emit(state.copyWith(
        status: FileUploadStatus.failure,
        errorMessage: failure.message,
      )),
          (fileUrl) => emit(state.copyWith(
        status: FileUploadStatus.success,
        progress: 1.0,
        uploadedFileUrl: fileUrl,
      )),
    );
  }

  void reset() {
    emit(const FileUploadState());
  }

  void selectType(int index){
    emit(state.copyWith(
      selectedIndex: index
    ));
  }
}