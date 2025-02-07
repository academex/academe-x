import 'package:academe_x/core/error/failure.dart';
import 'package:academe_x/features/profile/domain/repositories/user_profile_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:academe_x/core/pagination/paginated_response.dart';
import 'package:academe_x/core/pagination/pagination_params.dart';
import 'package:academe_x/features/home/domain/entities/post/post_entity.dart';
import 'package:academe_x/features/auth/auth.dart';

class ProfileUseCase {
  final ProfileRepository repository;

  ProfileUseCase(this.repository);

  Future<Either<Failure, PaginatedResponse<PostEntity>>> loadPosts(
    PaginationParams params,
  ) async {
    return await repository.loadPosts(params);
  }

  Future<Either<Failure, UserResponseEntity>> getUserProfile(
    String userId,
  ) async {
    return await repository.getUserProfile(userId);
  }
}
