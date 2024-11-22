import 'package:flutter/material.dart';
import 'academeX_main.dart';
import 'lib.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize environment
  const envString = String.fromEnvironment('ENVIRONMENT', defaultValue: 'dev');
  final environment = Environment.values.firstWhere(
        (e) => e.name == envString,
    orElse: () => Environment.dev,
  );
  await AppConfig.initialize(environment);
  runApp(const AcademeXMain());
}



