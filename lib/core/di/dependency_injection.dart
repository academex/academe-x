import 'package:academe_x/features/features.dart';
import 'package:academe_x/features/home/presentation/controllers/cubits/create_post/show_tag_cubit.dart';
import 'package:academe_x/features/home/presentation/controllers/cubits/create_post/tag_cubit.dart';
import 'package:academe_x/features/home/presentation/controllers/states/create_post/tag_state.dart';
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

  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(authUseCase: getIt()),
  getIt.registerFactory<CreatePostCubit>(
    () => CreatePostCubit(InitialState(), createPostUseCase: getIt()),
  );

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
  getIt.registerFactory<TagCubit>(
    () => TagCubit(TagState(selectedTags: [MockData.tags.first])),
  );
  getIt.registerFactory<ShowTagCubit>(
    () => ShowTagCubit(false),
  );
  getIt.registerFactory<ConnectivityCubit>(
    () => ConnectivityCubit(),
  );

  getIt.registerFactory<PostImageCubit>(
    () => PostImageCubit(),
  );
  getIt.registerFactory<SignupCubit>(
        () => SignupCubit(authUseCase: getIt(),),
  );

  getIt.registerFactory<CollegeCubit>(
    () => CollegeCubit(),
  );

}

void _initUseCases() {
  getIt.registerLazySingleton<AuthenticationUseCase>(
    () => AuthenticationUseCase(authenticationRepository: getIt()),
  );
  getIt.registerLazySingleton<CreatePostUseCase>(
    () => CreatePostUseCase(createPostRepository: getIt()),
  );
}

void _initRepositories() {
  getIt.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(remoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<CreatePostRepository>(
    () => CreatePostRepositoryImp(createPostRemoteDataSourse: getIt()),
  );
}

void _initDataSources() {
  getIt.registerLazySingleton<AuthenticationRemoteDataSource>(
    () => AuthenticationRemoteDataSource(
      apiController: getIt(),
      internetConnectionChecker: getIt(),
    ),
  );

  getIt.registerLazySingleton<CreatePostRemoteDataSource>(
    () => CreatePostRemoteDataSource(
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

  getIt.registerFactory<StorageService>(
    () => StorageService(),
  );
}