import 'package:flutter/material.dart';
import 'lib.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const envString = String.fromEnvironment('ENVIRONMENT', defaultValue: 'dev');
  final environment = Environment.values.firstWhere(
        (e) => e.name == envString,
    orElse: () => Environment.dev,
  );
  await AppConfig.initialize(environment);
  runApp(const AcademeXMain());
  // test commit
}