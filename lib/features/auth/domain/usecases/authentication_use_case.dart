
import 'package:academe_x/features/auth/domain/entities/response/updated_user_entity.dart';
import 'package:academe_x/lib.dart';
import 'package:dartz/dartz.dart';

import '../entities/request/update_profile_request_entity.dart';

class AuthenticationUseCase {
  AuthenticationRepository authenticationRepository;
  AuthenticationUseCase({required this.authenticationRepository});

  Future<Either<Failure, AuthTokenEntity>> login(LoginRequsetEntity user) async {
    return await authenticationRepository.login(user);

  }

  Future<Either<Failure, AuthTokenEntity>> signup(SignupRequestEntity userRegesteration) async {
    return await authenticationRepository.signup(userRegesteration);
  }
  Future<Either<Failure, UpdatedUserEntity>> updateProfile(Map<String, dynamic> user) async {
    return await authenticationRepository.updateProfile(user);
  }

  // Future<Either<Failure, List<CollegeEntity>>> getColleges() async {
  //   return await authenticationRepository.getColleges();
  // }
  //
  // Future<Either<Failure, List<MajorEntity>>> getMajorsByCollege(String collegeName) async {
  //   return await authenticationRepository.getMajorsByCollege(collegeName);
  // }


}