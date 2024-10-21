// import 'package:academe_x/features/home/data/datasources/home_remote_data_source.dart';
// import 'package:academe_x/features/home/domain/entities/home/home_product_data.dart';
// import 'package:academe_x/features/home/domain/repositories/home_repository.dart';
// import 'package:dartz/dartz.dart';
//
// import '../../../../core/error/exception.dart';
// import '../../../../core/error/failure.dart';
// import '../../presentaion/model/home_product_model.dart';
//
// class HomeProductRepositoryImpl implements HomeProductRepository {
//   // final NetworkConnection networkConnection;
//   final HomeRemoteDataSource remoteDataSource;
//
//   HomeProductRepositoryImpl({required this.remoteDataSource});
//
//   @override
//   Future<Either<Failure, List<HomeProductModel>>> getProductHomeData() async {
//     // TODO: implement getProductHomeData
//     try {
//       final result = await remoteDataSource.getProducts();
//
//       return Right(result);
//     } on ServerException {
//       return Left(ServerFailure(message: 'something went wrong'));
//     }
//   }
//
// }