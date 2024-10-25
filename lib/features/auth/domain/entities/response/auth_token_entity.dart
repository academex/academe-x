
import 'package:academe_x/features/auth/domain/entities/response/user_response_entity.dart';

class AuthTokenEntity {
  UserResponseEntity user;
  String accessToken;

  AuthTokenEntity({
    required this.user,
    required this.accessToken,
  });
}