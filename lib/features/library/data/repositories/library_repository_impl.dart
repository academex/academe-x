import 'package:academe_x/core/error/exception.dart';
import 'package:academe_x/core/pagination/paginated_response.dart';
import 'package:academe_x/core/pagination/pagination_params.dart';
import 'package:academe_x/features/auth/domain/entities/response/user_response_entity.dart';
import 'package:academe_x/features/home/domain/entities/post/post_entity.dart';
import 'package:academe_x/features/library/data/library_model.dart';
import 'package:academe_x/features/library/domain/entities/file_entity.dart';
import 'package:academe_x/features/library/domain/entities/library_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:academe_x/core/error/failure.dart';
import 'package:academe_x/features/profile/data/datasources/profile_remote_data_source.dart';

import '../../../auth/data/models/response/updated_user_model.dart';
import '../../../auth/domain/entities/response/updated_user_entity.dart';
import '../../../home/data/models/post/post_model.dart';
import '../../domain/repositories/user_library_repositories.dart';
import '../datasources/library_remote_data_source.dart';

class LibraryRepositoryImpl implements LibraryRepository {
  final LibraryRemoteDataSource remoteDataSource;

  LibraryRepositoryImpl({required this.remoteDataSource});


  @override
  Future<Either<Failure, List<LibraryModel>>> loadLibrary(
      PaginationParams paginationParams) async {
    try {
      // Try to get from network
      final result = await remoteDataSource.loadLibrary(paginationParams);
      return Right(result);
    } on OfflineException catch (e) {
      return Left(NoInternetConnectionFailure(
        message: e.errorMessage,
      ));
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
        ),
      );
    } on TimeOutExeption catch (e) {
      return Left(
        TimeOutFailure(
          message: e.errorMessage,
        ),
      );
    } catch (e, stack) {
      return Left(ServerFailure(message: 'An unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> starFile(int fileId,) async {
    try {
      // Try to get from network
      final result = await remoteDataSource.starFile(fileId);
      return Right(result);
    } on OfflineException catch (e) {
      return Left(NoInternetConnectionFailure(
        message: e.errorMessage,
      ));
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
        ),
      );
    } on TimeOutExeption catch (e) {
      return Left(
        TimeOutFailure(
          message: e.errorMessage,
        ),
      );
    } catch (e, stack) {
      return Left(ServerFailure(message: 'An unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, LibraryModel>> pickFile() async {
    try {
      final fileModel = await remoteDataSource.pickFile();

      if (fileModel == null) {
        // User canceled the picker
        return Left(FilePickingFailure(message: 'File picking canceled'));
      }

      return Right(fileModel);
    } catch (e) {
      return Left(FilePickingFailure(message: 'Failed to pick file: ${e.toString()}'));
    }
  }


  @override
  Future<Either<Failure, String>> uploadFile(FileEntity fileInfo,LibraryEntity file, void Function(double) progressCallback) async {
    try {
      final fileModel = LibraryModel.fromEntity(file);
      final fileUrl = await remoteDataSource.uploadFile(fileInfo,fileModel, progressCallback);
      return Right(fileUrl);
    } catch (e) {
      return Left(FileUploadFailure(message:'Failed to upload file: ${e.toString()}'));
    }
  }
}
