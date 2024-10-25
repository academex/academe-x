
import 'package:academe_x/core/error/failure.dart';
import 'package:academe_x/features/auth/data/models/requset/login_requset_model.dart';
import 'package:academe_x/features/auth/domain/entities/response/auth_token_entity.dart';
import 'package:academe_x/features/auth/domain/repositories/authentication_repository.dart';
import 'package:dartz/dartz.dart';
class AuthenticationUseCase {
  AuthenticationRepository authenticationRepository;
  AuthenticationUseCase({required this.authenticationRepository});

  Future<Either<Failure, AuthTokenEntity>> login(LoginRequsetModel user) async {
    return await authenticationRepository.login(user);

  }

}