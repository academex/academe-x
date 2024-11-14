import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'lib.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await StorageService.init();

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
