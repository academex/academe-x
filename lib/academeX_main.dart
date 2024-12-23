import 'package:academe_x/core/utils/extensions/auth_cache_manager.dart';
import 'package:academe_x/features/college_major/controller/cubit/college_major_cubit.dart';
import 'package:academe_x/features/home/presentation/controllers/cubits/post/posts_cubit.dart';
import 'package:academe_x/features/home/presentation/controllers/states/post/post_state.dart';
import 'package:academe_x/features/home/presentation/widgets/create_post_widgets/create_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'core/utils/deep_link_service.dart';
import 'core/utils/go_router.dart';
import 'core/utils/network/cubits/connectivity_cubit.dart';
import 'features/college_major/controller/cubit/get_tags_cubit.dart';
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


      BlocProvider<PostsCubit>(
        create: (context) => getIt<PostsCubit>(),
      ),

      BlocProvider<CollegeMajorsCubit>(
        create: (context) => getIt<CollegeMajorsCubit>()..initCollegeMajorForApp(),
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
          listenWhen: (previous, current) => previous!=current ,
        listener: (context, status) async{



          if (status == ConnectivityStatus.disconnected) {

            _showNoConnectionBanner(context, ConnectivityStatus.disconnected);
          }

          if (status == ConnectivityStatus.connected) {
            _showNoConnectionBanner(context, ConnectivityStatus.connected);
          }
        },
        ),

        BlocListener<PostsCubit, PostsState>(
          listenWhen: (previous, current) {
            return previous.creationState != current.creationState;
          },
          listener: (context, state) {
            if(state.creationState == CreationStatus.initial) return;
          bool isLoading = state.creationState == CreationStatus.loading;
          bool isSuccess = state.creationState == CreationStatus.success;
          bool isFailure = state.creationState == CreationStatus.failure;
          // Logger().f(NavigationService.navigatorKey.currentContext);
          // if(state.creationState == CreationStatus.loading) Navigator.pop(context);


          ScaffoldMessenger.of(context).clearSnackBars();
          // ScaffoldMessenger.of(context).hideCurrentSnackBar();
          Logger().f(state.creationState);
          if(isLoading || isFailure || isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: GestureDetector(
                  onTap: () => CreatePost().showCreatePostModal(NavigationService.navigatorKey.currentContext!),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppText(
                        fontSize: 12.sp,
                        text: isLoading?'جار رفع منشورك':isFailure?state.creationPostErrorMessage!:'تم نشر منشورك بنجاح',
                        color: Colors.white,
                      ),
                      if(isLoading)
                      2.ph(),
                      if(isLoading)
                      const LinearProgressIndicator(
                        backgroundColor: Colors.white,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    ],
                  ),
                ),
                backgroundColor: isLoading?Colors.green.shade800:isFailure?Colors.red:Colors.green,
                duration:  Duration(seconds: isLoading?500:2),
                dismissDirection: DismissDirection.horizontal,
                behavior:SnackBarBehavior.fixed,
                padding:EdgeInsets.symmetric(vertical: 10.h,horizontal: 15.w),


              ),
            );
          }


        },),

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