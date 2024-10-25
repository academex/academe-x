// import 'package:academe_x/features/home/domain/usecases/home_use_case.dart';
// import 'package:academe_x/features/home/presentaion/controllers/cubits/home/home_states.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class HomeProductCubit extends Cubit<HomeProductStates> {
//   final HomeProductUseCase _homeProductUseCase;
//   HomeProductCubit({required HomeProductUseCase homeUseCase}) :_homeProductUseCase=homeUseCase, super(HomeProductInitial());
//
//   getHomeData() async {
//     emit(HomeProductLoadingState());
//     var result = await _homeProductUseCase.getHomeData();
//
//     result.fold((l) {
//       emit(HomeProductErrorState(message: l.message));
//     }, (r) {
//       // Logger().i(r);
//       emit(HomeProductLoadedState(products: r));
//     });
//
//   }
// }
