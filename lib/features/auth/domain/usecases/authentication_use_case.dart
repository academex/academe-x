
import 'package:academe_x/lib.dart';
import 'package:dartz/dartz.dart';

class AuthenticationUseCase {
  AuthenticationRepository authenticationRepository;
  AuthenticationUseCase({required this.authenticationRepository});

  Future<Either<Failure, AuthTokenEntity>> login(LoginRequsetEntity user) async {
    return await authenticationRepository.login(user);

  }

  Future<Either<Failure, AuthTokenEntity>> signup(SignupRequestEntity userRegesteration) async {
    return await authenticationRepository.signup(userRegesteration);
  }

  Future<Either<Failure, List<CollegeEntity>>> getColleges() async {
    return await authenticationRepository.getColleges();
  }

  Future<Either<Failure, List<MajorEntity>>> getMajorsByCollege(String collegeName) async {
    return await authenticationRepository.getMajorsByCollege(collegeName);
  }


}