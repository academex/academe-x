// import 'package:academe_x/core/di/dependency_injection.dart';
// import 'package:academe_x/features/auth/presentation/controllers/cubits/authentication_cubit.dart';
// import 'package:academe_x/features/home/presentation/controllers/cubits/home/bottom_nav_cubit.dart';
// import 'package:academe_x/features/home/presentaion/controllers/cubits/create_post/create_post_icons_cubit.dart';
// import 'package:academe_x/features/home/presentaion/controllers/states/create_post/create_post_icons_state.dart';
// import 'package:academe_x/navigation/app_router.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
//
// void main() async{
//   await init();
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(const Main());
// }
//
// class Main extends StatelessWidget {
//   const Main({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(
//           375, 812),
//       minTextAdapt: true,
//       splitScreenMode: true,
//       builder: (_ , child) {
//         return MultiBlocProvider(
//           providers: [
//             BlocProvider<AuthenticationCubit>(
//               create: (context) => getIt<AuthenticationCubit>(), // Providing the AuthCubit
//             ),
//             BlocProvider<AuthActionCubit>(
//               create: (context) => getIt<AuthActionCubit>(), // Providing the AuthCubit
//             ),
//             BlocProvider<BottomNavCubit>(
//               create: (context) => getIt<BottomNavCubit>(), // Providing the AuthCubit
//             ),
//             BlocProvider(
//               create: (context) => PickerCubit(CreatePostIconsInit()),
//             )
//           ],
//           child: MaterialApp(
//             title: 'AcademeX',
//             locale: const Locale('ar'), // Set the locale to Arabic
//             supportedLocales:  AppLocalizations.supportedLocales,
//             localizationsDelegates: const [
//               AppLocalizations.delegate,
//               GlobalMaterialLocalizations.delegate,
//               GlobalWidgetsLocalizations.delegate,
//               GlobalCupertinoLocalizations.delegate,
//             ],
//
//
//             debugShowCheckedModeBanner: false,
//             theme: ThemeData(
//               fontFamily: 'Cairo',
//               primarySwatch: Colors.blue,
//               colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(
//                 surface: Colors.white,
//               ),
//             ),
//             initialRoute: '/login',
//             onGenerateRoute: AppRouter.generateRoute,
//           ),
//         );
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'lib.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

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
      BlocProvider<AuthenticationCubit>(
        create: (context) => getIt<AuthenticationCubit>(),
      ),
      BlocProvider<AuthActionCubit>(
        create: (context) => getIt<AuthActionCubit>(),
      ),
      BlocProvider<BottomNavCubit>(
        create: (context) => getIt<BottomNavCubit>(),
      ),
      BlocProvider<PickerCubit>(
        create: (context) => getIt<PickerCubit>(),
      ),
      BlocProvider<ConnectivityCubit>(
        create: (context) => getIt<ConnectivityCubit>(),
      ),

      BlocProvider<PostImageCubit>(
        create: (context) => getIt<PostImageCubit>(),
      ),
    ];
  }

  Widget _buildMaterialApp() {
    return MaterialApp(
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
      initialRoute: '/login',
      onGenerateRoute: AppRouter.generateRoute,
      builder: _buildAppWithExtra,
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
    SizeConfig.init(context);
    return BlocListener<ConnectivityCubit, ConnectivityStatus>(
      listener: (context, status) {
        if (status == ConnectivityStatus.disconnected) {
          _showNoConnectionBanner(context);
        }
      },
      child: child!,
    );
  }

  void _showNoConnectionBanner(BuildContext context) {

    context.showSnackBar(message: 'لا يوجد اتصال بالإنترنت',error: true);
  }
}

class AppLifecycleManager extends StatefulWidget {
  final Widget child;

  const AppLifecycleManager({
    required this.child,
    super.key,
  });

  @override
  State<AppLifecycleManager> createState() => _AppLifecycleManagerState();
}

class _AppLifecycleManagerState extends State<AppLifecycleManager>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _onResumed(context);
        break;
      case AppLifecycleState.paused:
        _onPaused(context);
        break;
      case AppLifecycleState.inactive:
        _onInactive(context);
        break;
      case AppLifecycleState.detached:
        _onDetached(context);
        break;
      default:
        break;
    }
  }

  void _onResumed(BuildContext context) {
    AppLogger.wtf('_onResumed');
    // Check authentication status
    // context.read<AuthenticationCubit>().checkAuthStatus();

    // Refresh data if needed
    final currentIndex = context.read<BottomNavCubit>().state;
    if (currentIndex == 0) { // If on home screen
      // Refresh posts
      // context.read<HomeCubit>().refreshPosts();
    }

    // Reconnect to services if needed
    // context.read<ChatCubit>().reconnect();

    // Check for new notifications
    // context.read<NotificationCubit>().checkNewNotifications();
  }

  void _onPaused(BuildContext context) {
    AppLogger.wtf('_onPaused');
    // Save any unsaved data
    // context.read<PostCubit>().saveDrafts();

    // Disconnect from services to save battery
    // context.read<ChatCubit>().disconnect();

    // Save app state
    // context.read<AppStateCubit>().saveState();
  }

  void _onInactive(BuildContext context) {
    AppLogger.wtf('_onInactive');
    // Handle when app becomes inactive (e.g., during a phone call)
    // Pause sensitive operations
    // context.read<MediaPlayerCubit>().pause();
  }

  void _onDetached(BuildContext context) {
    AppLogger.wtf('_onDetached');

    // Clean up resources when app is being terminated
    // context.read<AppStateCubit>().cleanup();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}