
import 'package:academe_x/lib.dart';
import 'package:dartz/dartz.dart';

class AuthenticationUseCase {
  AuthenticationRepository authenticationRepository;
  AuthenticationUseCase({required this.authenticationRepository});

  Future<Either<Failure, AuthTokenEntity>> login(LoginRequsetEntity user) async {
    return await authenticationRepository.login(user);

  }

}