import 'package:academe_x/features/auth/data/models/requset/login_requset_model.dart';
import 'package:academe_x/features/auth/domain/entities/response/auth_token_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class AuthenticationRepository {
  AuthenticationRepository();
  Future<Either<Failure, AuthTokenEntity>>login(LoginRequsetModel user);
}