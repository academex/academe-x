import 'dart:async';
import 'package:academe_x/lib.dart';

import 'package:dartz/dartz.dart';


class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource remoteDataSource;

  AuthenticationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, AuthTokenModel>> login(LoginRequsetEntity user) async {
    try {
      final result = await remoteDataSource.login(
        LoginRequsetModel.fromEntity(user),
      );
      return Right(result);
    } on ValidationException catch (e) {
      return Left(ValidationFailure(messages: e.messages, message: ''));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(message: e.message));
    } on OfflineException catch (e) {
      return Left(NoInternetConnectionFailure(message: e.errorMessage));
    } on TimeOutExeption catch (e) {
      return Left(TimeOutFailure(message: e.errorMessage));
    } catch (e) {
      return Left(ServerFailure(message: 'An error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, AuthTokenModel>> signup(SignupRequestEntity user) async {
    try {
      final result = await remoteDataSource.signup(
        SignupRequestModel.fromEntity(user),
      );
      return Right(result);
    } on ValidationException catch (e) {
      return Left(ValidationFailure(messages: e.messages, message: ''));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(message: e.message));
    } on OfflineException catch (e) {
      return Left(NoInternetConnectionFailure(message: e.errorMessage));
    } on TimeOutExeption catch (e) {
      return Left(TimeOutFailure(message: e.errorMessage));
    } catch (e) {
      return Left(ServerFailure(message: 'An error occurred: $e'));
    }
  }

}



