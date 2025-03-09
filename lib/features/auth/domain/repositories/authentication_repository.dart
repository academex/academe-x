import 'package:academe_x/lib.dart';
import 'package:dartz/dartz.dart';

import '../entities/request/update_profile_request_entity.dart';
import '../entities/response/updated_user_entity.dart';


abstract class AuthenticationRepository {
  AuthenticationRepository();
  Future<Either<Failure, AuthTokenEntity>>login(LoginRequsetEntity user);
  Future<Either<Failure, AuthTokenEntity>>signup(SignupRequestEntity userRegesteration);
  Future<Either<Failure, UpdatedUserEntity>>updateProfile(Map<String, dynamic> user);
  // Future<Either<Failure, List<CollegeEntity>>>getColleges();
  // Future<Either<Failure, List<MajorEntity>>>getMajorsByCollege(String collegeName);
}