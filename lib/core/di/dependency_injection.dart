import 'package:academe_x/features/features.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../core.dart';

final getIt = GetIt.instance;

Future<void> init() async {

  // Cubits
  _initCubits();

  // Use Cases
  _initUseCases();

  // Repositories
  _initRepositories();

  // Data Sources
  _initDataSources();

  // External Dependencies
  _initExternalDependencies();
}

void _initCubits() {
  getIt.registerFactory<AuthenticationCubit>(
        () => AuthenticationCubit(authUseCase: getIt()),
  );

  getIt.registerFactory<AuthActionCubit>(
        () => AuthActionCubit(false),
  );

  getIt.registerFactory<BottomNavCubit>(
        () => BottomNavCubit(),
  );

  getIt.registerFactory<HomeCubit>(
        () => HomeCubit(),
  );

  getIt.registerFactory<PickerCubit>(
        () => PickerCubit(CreatePostIconsInit()),
  );
  getIt.registerFactory<ConnectivityCubit>(
        () => ConnectivityCubit(),
  );

  getIt.registerFactory<PostImageCubit>(
        () => PostImageCubit(),
  );
}

void _initUseCases() {
  getIt.registerLazySingleton<AuthenticationUseCase>(
        () => AuthenticationUseCase(authenticationRepository: getIt()),
  );
}

void _initRepositories() {
  getIt.registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImpl(remoteDataSource: getIt()),
  );
}

void _initDataSources() {
  getIt.registerLazySingleton<AuthenticationRemoteDataSource>(
        () => AuthenticationRemoteDataSource(
      apiController: getIt(),
      internetConnectionChecker: getIt(),
    ),
  );
}

void _initExternalDependencies() {
  getIt.registerLazySingleton(() => ApiController());
  getIt.registerFactory<InternetConnectionChecker>(
        () => InternetConnectionChecker(),
  );
}