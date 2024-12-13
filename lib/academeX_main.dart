import 'package:academe_x/core/utils/extensions/auth_cache_manager.dart';
import 'package:academe_x/features/college_major/controller/cubit/college_major_cubit.dart';
import 'package:academe_x/features/home/presentation/controllers/cubits/post/posts_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/utils/deep_link_service.dart';
import 'core/utils/go_router.dart';
import 'features/college_major/controller/cubit/get_tags_cubit.dart';
import 'features/home/presentation/controllers/cubits/create_post/create_post_cubit.dart';
import 'features/home/presentation/controllers/cubits/create_post/show_tag_cubit.dart';
import 'features/home/presentation/controllers/cubits/create_post/tag_cubit.dart';
import 'lib.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class AcademeXMain extends StatelessWidget {
  const AcademeXMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: _getProviders(),

        child: AppLifecycleManager(
          child: _buildApp(),
        ));
  }

  Widget _buildApp() {
    return _buildMaterialApp();
  }

  List<BlocProvider> _getProviders() {
    return [
      BlocProvider<AuthActionCubit>(
        create: (context) => getIt<AuthActionCubit>(),
      ),
      BlocProvider<LoginCubit>(
        create: (context) => getIt<LoginCubit>(),
      ),
      BlocProvider<BottomNavCubit>(
        create: (context) => getIt<BottomNavCubit>(),
      ),
      BlocProvider<PickerCubit>(
        create: (context) => getIt<PickerCubit>(),
      ),
      BlocProvider<TagCubit>(
        create: (context) => getIt<TagCubit>(),
      ),
      BlocProvider<ShowTagCubit>(
        create: (context) => getIt<ShowTagCubit>(),
      ),
      BlocProvider<ConnectivityCubit>(
        create: (context) => getIt<ConnectivityCubit>(),
      ),
      BlocProvider<PostImageCubit>(
        create: (context) => getIt<PostImageCubit>(),
      ),
      BlocProvider<CreatePostCubit>(
        create: (context) => getIt<CreatePostCubit>(),
      ),

      BlocProvider<PostsCubit>(
        create: (context) => getIt<PostsCubit>()..loadTagPosts(),
      ),

      BlocProvider<CollegeMajorsCubit>(
        create: (context) => getIt<CollegeMajorsCubit>()..initCollegeMajor(),
      ),
      BlocProvider<GetTagsCubit>(
        create: (context) => getIt<GetTagsCubit>()..getTags(),
      ),
    ];
  }

  Widget _buildMaterialApp() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp.router(
        routerConfig: goRouter,

        title: 'AcademeX',
        locale: const Locale('ar'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],


        debugShowCheckedModeBanner: false,
        theme: _buildTheme(),
        builder: (context, child) => _buildAppWithExtra(context, child),
      ),
    );
  }

  ThemeData _buildTheme() {
    return ThemeData(
      fontFamily: 'Cairo',
      primarySwatch: Colors.blue,
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(
        surface: Colors.white,
      ),
    );
  }

  Widget _buildAppWithExtra(BuildContext context, Widget? child) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      DeepLinkService.initialize();
    });
    SizeConfig.init(context);




    return MultiBlocListener(listeners: [

        BlocListener<ConnectivityCubit, ConnectivityStatus>(
        listener: (context, status) async{



          if (status == ConnectivityStatus.disconnected) {

            _showNoConnectionBanner(context, ConnectivityStatus.disconnected);
          }

          if (status == ConnectivityStatus.connected) {
            _showNoConnectionBanner(context, ConnectivityStatus.connected);
          }
        },
        ),
    ], child: child!);
  }

  void _showNoConnectionBanner(
      BuildContext context, ConnectivityStatus disconnected) {
    switch (disconnected) {
      case ConnectivityStatus.connected:
        AppLogger.success('connected');
        context.showSnackBar(
          message: 'تم الاتصال بالانترنت',
        );

        break;
      case ConnectivityStatus.disconnected:
        AppLogger.success('not connected');
        context.showSnackBar(message: 'لا يوجد اتصال بالإنترنت', error: true);
        break;
    }
  }
}
class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();
}