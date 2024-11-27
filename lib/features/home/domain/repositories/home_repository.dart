import 'package:academe_x/features/home/data/models/post/post_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class HomeProductRepository {
  HomeProductRepository();
  Future<Either<Failure, List<PostModel>>>getPosts();

}