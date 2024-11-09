<<<<<<< HEAD
//
// import 'package:academe_x/core/error/failure.dart';
// import 'package:academe_x/features/home/presentaion/model/home_product_model.dart';
// import 'package:dartz/dartz.dart';
//
// import '../repositories/home_repository.dart';
//
// class HomeProductUseCase {
//   HomeProductRepository homeProductRepo;
//   HomeProductUseCase({required this.homeProductRepo});
//
//   Future<Either<Failure, List<HomeProductModel>>> getHomeData() async {
//     return await homeProductRepo.getProductHomeData();
//
//   }
//
//
//
//
//
//
// }
=======

import 'package:academe_x/core/error/failure.dart';
import 'package:academe_x/features/home/presentaion/model/home_product_model.dart';
import 'package:dartz/dartz.dart';

import '../repositories/home_repository.dart';

class HomeProductUseCase {
  HomeProductRepository homeProductRepo;
  HomeProductUseCase({required this.homeProductRepo});

  Future<Either<Failure, List<HomeProductModel>>> getHomeData() async {
    return await homeProductRepo.getProductHomeData();

  }






}
>>>>>>> 536135a (Description of changes)
