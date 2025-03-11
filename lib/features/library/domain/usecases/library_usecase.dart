import 'package:academe_x/core/error/failure.dart';
import 'package:academe_x/features/profile/domain/repositories/user_profile_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:academe_x/core/pagination/paginated_response.dart';
import 'package:academe_x/core/pagination/pagination_params.dart';
import 'package:academe_x/features/home/domain/entities/post/post_entity.dart';
import 'package:academe_x/features/auth/auth.dart';

import '../../../auth/domain/entities/response/updated_user_entity.dart';
import '../entities/library_entity.dart';
import '../repositories/user_library_repositories.dart';

class LibraryUseCase {
  final LibraryRepository repository;

  LibraryUseCase(this.repository);

  Future<Either<Failure, List<LibraryEntity>>> loadLibrary(
    PaginationParams params,
  ) async {
    return await repository.loadLibrary(params);
  }

}
