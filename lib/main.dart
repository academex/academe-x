<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'lib.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
=======
import 'package:academe_x/features/launch/presentation/screens/launch_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'features/auth/presentation/screens/login_screen.dart';
import 'features/auth/presentation/screens/robot_intro.dart';

void main() {
>>>>>>> 536135a (Description of changes)
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD

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
          _showNoConnectionBanner(context,ConnectivityStatus.disconnected);
        }

        if (status == ConnectivityStatus.connected) {
          _showNoConnectionBanner(context,ConnectivityStatus.connected);
        }

      },
      child: child!,
    );
  }

  void _showNoConnectionBanner(BuildContext context, ConnectivityStatus disconnected) {

    switch(disconnected){
      case ConnectivityStatus.connected:
        AppLogger.success('connected');
        context.showSnackBar(message: 'تم الاتصال بالانترنت',);

        break;
      case ConnectivityStatus.disconnected:
        AppLogger.success('not connected');
        context.showSnackBar(message: 'لا يوجد اتصال بالإنترنت',error: true);
        break;
    }

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
=======
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(
    //     systemNavigationBarColor: Colors.transparent,
    //     statusBarColor: Colors.transparent,
    //     systemNavigationBarIconBrightness: Brightness.dark,
    //   ),
    // );
    return ScreenUtilInit(
      designSize: const Size(
          375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_ , child) {
        return MaterialApp(

          title: 'AcademeX',
          locale: const Locale('ar'), // Set the locale to Arabic
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('ar', ''),
            Locale('ar', 'IQ'),
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: GoogleFonts.cairo().fontFamily,
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(background: Colors.white),
          ),
          initialRoute: '/login',
          routes: {
            '/lunch': (context) => const LunchScreen(),
            '/login': (context) => const LoginScreen(),
            '/robot_intro': (context) => const RobotIntroScreen(),
            // '/verification_code': (context) =>  VerificationCode(),
            // '/forgot_Password': (context) =>  const ForgotPassword(),
          },
        );
      },
    );
  }
}
>>>>>>> 536135a (Description of changes)
