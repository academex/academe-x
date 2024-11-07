


import 'package:academe_x/core/network/api_controller.dart';
import 'package:academe_x/features/auth/data/datasources/authentication_remote_data_source.dart';
import 'package:academe_x/features/auth/data/repositories/authentication_repository_impl.dart';
import 'package:academe_x/features/auth/domain/repositories/authentication_repository.dart';
import 'package:academe_x/features/auth/domain/usecases/authentication_use_case.dart';
import 'package:academe_x/features/auth/presentation/controllers/cubits/authentication_cubit.dart';
import 'package:academe_x/features/home/presentation/controllers/cubits/home/bottom_nav_cubit.dart';
import 'package:academe_x/features/home/presentation/controllers/cubits/home/home_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final getIt = GetIt.instance;


Future<void> init() async {
  /// Cubits ///
  getIt.registerFactory<AuthenticationCubit>(
        () {
      return AuthenticationCubit(
        authUseCase: getIt(),
      );
    },
  );

  getIt.registerFactory<AuthActionCubit>(
        () {
      return AuthActionCubit(false);
    },
  );
  getIt.registerFactory<BottomNavCubit>(
        () {
      return BottomNavCubit();
    },
  );
  getIt.registerFactory<HomeCubit>(
        () {
      return HomeCubit();
    },
  );


  // /// Usecases ///
  getIt.registerLazySingleton<AuthenticationUseCase>(
          () => AuthenticationUseCase(authenticationRepository:  getIt()));

  // /// Repository ///
  getIt.registerLazySingleton<AuthenticationRepository>(
          () =>AuthenticationRepositoryImpl(remoteDataSource: getIt(),));

  // /// Data Source ///
  getIt.registerLazySingleton<AuthenticationRemoteDataSource>(() =>AuthenticationRemoteDataSource(apiController: getIt(),internetConnectionChecker: getIt()));

  /// Externals ///
  getIt.registerLazySingleton(() => ApiController());
  getIt.registerFactory<InternetConnectionChecker>(() {
    return InternetConnectionChecker();

  },);


  // // Observers
  // Bloc.observer = MyBlocObserver();
}
