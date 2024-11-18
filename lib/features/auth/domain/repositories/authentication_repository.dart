import 'package:academe_x/lib.dart';
import 'package:dartz/dartz.dart';


abstract class AuthenticationRepository {
  AuthenticationRepository();
  Future<Either<Failure, AuthTokenEntity>>login(LoginRequsetModel user);
}