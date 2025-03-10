import 'package:academe_x/core/utils/storage/storage.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:academe_x/lib.dart';

import '../utils/storage/cache/hive_cache_manager.dart';

enum Environment { dev, staging, prod }

class AppConfig {
  static late Environment environment;
  static late String apiUrl;
  static late bool enableAnalytics;
  static late bool enableCrashlytics;
  static late PackageInfo packageInfo;
  static late SharedPreferences prefs;
  static late HiveCacheManager cacheManager;

  // API endpoints
  static late String authEndpoint;
  static late String profileEndpoint;
  static late String tagsEndpoint;
  static late String postsEndpoint;
  static late String userPostsEndpoint;
  static late String commentEndpoint;
  static late String getTagsEndpoint;
  static late String libraryEndpoint;

  // Feature flags
  static late bool enablePushNotifications;
  static late bool enableOfflineMode;
  static late bool enableDebugMode;

  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  // static const Duration receiveTimeout = Duration(seconds: 30);

  // Cache configuration
  static const Duration cacheMaxAge = Duration(days: 7);
  static const int maxCacheSize = 50 * 1024 * 1024; // 50MB

  static Future<void> initialize(Environment env) async {
    await init();
    environment = env;
    _configureEnvironment(env);
    await _loadPackageInfo();
    // await _initializeStorage();
    cacheManager = HiveCacheManager();
    await _initializeCache();

    await _initializeServices();
  }

  static Future<void> _loadPackageInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
  }

  static void _configureEnvironment(Environment env) {
    switch (env) {
      case Environment.dev:
        apiUrl = 'https://academex-1.onrender.com';
        authEndpoint = '$apiUrl/auth';
        profileEndpoint = '$apiUrl/user';
        tagsEndpoint = '$apiUrl/tag';
        postsEndpoint = '$apiUrl/post';
        userPostsEndpoint = '$apiUrl/post/user';
        commentEndpoint = '$apiUrl/comment';
        getTagsEndpoint = '$apiUrl/tag/user-college-tags';
        libraryEndpoint = '$apiUrl/library';

        enableAnalytics = false;
        enableCrashlytics = false;
        enablePushNotifications = false;
        enableOfflineMode = true;
        enableDebugMode = true;
        break;

      case Environment.staging:
        apiUrl = 'https://staging-api.academx.com';
        authEndpoint = '$apiUrl/auth';
        tagsEndpoint = '$apiUrl/colleges';
        libraryEndpoint = '$apiUrl/library';
        enableAnalytics = true;
        enableCrashlytics = true;
        enablePushNotifications = true;
        enableOfflineMode = true;
        enableDebugMode = true;
        break;

      case Environment.prod:
        apiUrl = 'https://api.academx.com';
        authEndpoint = '$apiUrl/auth';
        tagsEndpoint = '$apiUrl/colleges';
        libraryEndpoint = '$apiUrl/library';

        enableAnalytics = true;
        enableCrashlytics = true;
        enablePushNotifications = true;
        enableOfflineMode = true;
        enableDebugMode = false;
        break;
    }
  }

  static Future<void> _initializeServices() async {
    if (enableAnalytics) {
      await _initializeAnalytics();
    }

    if (enableCrashlytics) {
      // await _initializeCrashlytics();
    }

    await _initializeCache();
    await _initializeLogging();
  }

  static Future<void> _initializeAnalytics() async {
    try {
      // final analytics = FirebaseAnalytics.instance;
      // await analytics.setAnalyticsCollectionEnabled(true);
      // await analytics.logAppOpen();
      // await analytics.setUserProperty(
      //   name: 'app_version',
      //   value: packageInfo.version,
      // );
      // await analytics.setUserProperty(
      //   name: 'environment',
      //   value: environment.name,
      // );
    } catch (e) {
      debugPrint('Failed to initialize analytics: $e');
    }
  }

  static Future<void> _initializeCache() async {
    try {
      debugPrint('Initializing cache...');

      // Initialize Hive
      await cacheManager.init();

      // Log cache initialization success in debug mode
      if (enableDebugMode) {
        debugPrint('Cache initialized successfully');
        debugPrint(
            'Cache size: ${await cacheManager.getAllStorageSizes()}KB');
        debugPrint(
            'Total cache size: ${(await cacheManager.getAllStorageSizes())['total']}KB');
      }
    } catch (e, stackTrace) {
      debugPrint('Failed to initialize cache: $e');
      debugPrint('Stack trace: $stackTrace');
      if (e.toString().contains('corrupted')) {
        await cacheManager.handleCacheCorruption();
      }
      rethrow;

      // Try to handle corruption
    }
  }

  static Future<void> _initializeLogging() async {
    if (enableDebugMode) {
      // Setup debug logging
    } else {
      // Setup production logging
    }
  }

  // Helper methods
  static bool get isProduction => environment == Environment.prod;
  static bool get isStaging => environment == Environment.staging;
  static bool get isDevelopment => environment == Environment.dev;

  static String get appVersion => packageInfo.version;
  static String get buildNumber => packageInfo.buildNumber;

  static Map<String, dynamic> get configDiagnostics {
    return {
      'environment': environment.name,
      'apiUrl': apiUrl,
      'appVersion': appVersion,
      'buildNumber': buildNumber,
      'enableAnalytics': enableAnalytics,
      'enableCrashlytics': enableCrashlytics,
      'enablePushNotifications': enablePushNotifications,
      'enableOfflineMode': enableOfflineMode,
      'enableDebugMode': enableDebugMode,
    };
  }

  static void logDiagnostics() {
    debugPrint('App Configuration:');
    configDiagnostics.forEach((key, value) {
      debugPrint('$key: $value');
    });
  }
}
