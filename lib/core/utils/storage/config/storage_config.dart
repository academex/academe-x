import 'package:academe_x/core/config/app_config.dart';
import 'package:flutter/foundation.dart';

class StorageConfig {
  static const String cacheBoxName = 'network_cache';
  static const String userBoxName = 'user_data';
  static const String settingsBoxName = 'app_settings';

  static const Duration defaultCacheDuration = Duration(hours: 1);
  static const int maxCacheItems = 100;
  static const int maxCacheSize = 1000 * 1024 * 1024; // 50MB


  // static bool get enableLogging => true;  // You might want to tie this to AppConfig.enableDebugMode

}