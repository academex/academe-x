import 'package:academe_x/core/error/failure.dart';
import 'package:academe_x/core/pagination/paginated_response.dart';
import 'package:academe_x/core/pagination/pagination_params.dart';
import 'package:academe_x/features/home/domain/entities/post/post_entity.dart';
import 'package:academe_x/features/auth/auth.dart';
import 'package:academe_x/features/library/domain/entities/library_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../auth/domain/entities/response/updated_user_entity.dart';
import '../../../home/data/models/post/post_model.dart';

abstract class LibraryRepository {
  LibraryRepository();

  Future<Either<Failure, List<LibraryEntity>>> loadLibrary(
    PaginationParams paginationParams,
  );
}
