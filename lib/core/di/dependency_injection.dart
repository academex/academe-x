import 'package:academe_x/features/features.dart';
import 'package:academe_x/features/home/presentation/controllers/cubits/create_post/show_tag_cubit.dart';
import 'package:academe_x/features/home/presentation/controllers/cubits/create_post/tag_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../features/home/data/repositories/create_post_repository_imp.dart';
import '../../features/home/domain/usecases/create_post_use_case.dart';
import '../../features/home/presentation/controllers/cubits/create_post/create_post_cubit.dart';
import '../core.dart';
// import '../services/hive_cache_manager.dart';

final getIt = GetIt.instance;

Future<void> init() async {




  // Cubits
  _initCubits();

  // State
  _initState();

  // Use Cases
  _initUseCases();

  // Repositories
  _initRepositories();

  // Data Sources
  _initDataSources();

  // External Dependencies
  await _initExternalDependencies();
}



void _initCubits() {
  getIt.registerFactory<LoginCubit>(() => LoginCubit(authUseCase: getIt()));

  getIt.registerFactory<CreatePostCubit>(
    () => CreatePostCubit(InitialState(), createPostUseCase: getIt()),
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
    () => SignupCubit(
      authUseCase: getIt(),
    ),
  );

  getIt.registerFactory<CollegeCubit>(
    () => CollegeCubit(),
  );
}

void _initState() {
  getIt.registerSingleton(FilePickerLoaded(null));
  getIt.registerSingleton(ImagePickerLoaded(null));
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
    () => AuthenticationRepositoryImpl(
        remoteDataSource: getIt(), cacheManager: getIt()),
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
        cacheManager: getIt()),
  );

  getIt.registerLazySingleton<CreatePostRemoteDataSource>(
    () => CreatePostRemoteDataSource(
      apiController: getIt(),
      internetConnectionChecker: getIt(),
    ),
  );
}

Future<void> _initExternalDependencies() async {
  final cacheManager = HiveCacheManager();
  await cacheManager.init();
  getIt.registerLazySingleton(() => cacheManager);
  getIt.registerLazySingleton(() => ApiController());
  getIt.registerLazySingleton(() => InternetConnectionChecker());
}
