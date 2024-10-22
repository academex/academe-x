import 'dart:async';

import 'package:academe_x/features/auth/data/datasources/authentication_remote_data_source.dart';
import 'package:academe_x/features/auth/data/models/requset/login_requset_model.dart';
import 'package:academe_x/features/auth/domain/repositories/authentication_repository.dart';
import 'package:academe_x/features/auth/data/models/response/auth_token_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  // final NetworkConnection networkConnection;
  final AuthenticationRemoteDataSource remoteDataSource;

  AuthenticationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure,AuthTokenModel>> login(LoginRequsetModel user) async {
    // TODO: implement getProductHomeData
    try {
      final result = await remoteDataSource.login(user);

      return Right(result);
    }on TimeoutException {
      return Left(TimeOutFailure(message: 'Request took longer than 10 seconds.'));
    }
    on ServerException {
      return Left(ServerFailure(message: 'something went wrong'));
    }
  }

}