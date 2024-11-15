import 'dart:async';
import 'package:academe_x/lib.dart';

import 'package:dartz/dartz.dart';


class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource remoteDataSource;

  AuthenticationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure,AuthTokenModel>> login(LoginRequsetModel user) async {
    try {
      final result = await remoteDataSource.login(user);
      return Right(result);
    }on WrongDataException catch (e) {
       return Left(WrongPasswordOrEmailFailure(message: e.errorMessage));
    }on OfflineException catch (e) {
      return Left(NoInternetConnectionFailure(message: e.errorMessage));
    }on TimeOutExeption catch (e) {
      return Left(TimeOutFailure(message: e.errorMessage));
    }
    on Exception catch (e) {
      return Left(ServerFailure(message: 'An error occurred: $e'));
    }
  }

}