import 'package:academe_x/lib.dart';
import 'package:dartz/dartz.dart';


abstract class AuthenticationRepository {
  AuthenticationRepository();
  Future<Either<Failure, AuthTokenEntity>>login(LoginRequsetEntity user);
  Future<Either<Failure, AuthTokenEntity>>signup(SignupRequestEntity userRegesteration);
  Future<Either<Failure, List<CollegeEntity>>>getColleges();
  Future<Either<Failure, List<MajorEntity>>>getMajorsByCollege(String collegeName);
}