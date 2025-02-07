import 'package:academe_x/core/error/failure.dart';
import 'package:academe_x/core/pagination/paginated_response.dart';
import 'package:academe_x/core/pagination/pagination_params.dart';
import 'package:academe_x/features/home/domain/entities/post/post_entity.dart';
import 'package:academe_x/features/auth/auth.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileRepository {
  ProfileRepository();

  Future<Either<Failure, PaginatedResponse<PostEntity>>> loadPosts(
    PaginationParams paginationParams,
  );

  Future<Either<Failure, UserResponseEntity>> getUserProfile(
    String userId,
  );
}
