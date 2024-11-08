enum Environment { dev, staging, prod }

class AppConfig {
  static late Environment environment;
  static late String apiUrl;
  static late bool enableAnalytics;
  static late bool enableCrashlytics;

  static Future<void> initialize(Environment env) async {
    environment = env;

    switch (env) {
      case Environment.dev:
        apiUrl = 'https://dev-api.academx.com';
        enableAnalytics = false;
        enableCrashlytics = false;
        break;
      case Environment.staging:
        apiUrl = 'https://staging-api.academx.com';
        enableAnalytics = true;
        enableCrashlytics = true;
        break;
      case Environment.prod:
        apiUrl = 'https://api.academx.com';
        enableAnalytics = true;
        enableCrashlytics = true;
        break;
    }

    await _initializeServices();
  }

  static Future<void> _initializeServices() async {
    // await StorageService.init();
    // await NetworkCache.init();
    if (enableAnalytics) {
      // Initialize analytics
    }
    if (enableCrashlytics) {
      // Initialize crashlytics
    }
  }
}