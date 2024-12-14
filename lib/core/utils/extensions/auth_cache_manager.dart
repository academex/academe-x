import 'dart:convert';
import 'package:academe_x/core/core.dart';
import 'package:academe_x/features/auth/auth.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../constants/cache_keys.dart';
import '../storage/cache/hive_cache_manager.dart';

extension AuthCacheManager on HiveCacheManager {
  // Cache the authenticated user
  Future<void> cacheAuthUser(AuthTokenEntity user) async {
    try {
      await cacheResponse<AuthTokenEntity>(
        CacheKeys.USER,
        user,
        duration: const Duration(days: 30),
        isUser: true
      );
      AppLogger.success('User cached successfully');
    } catch (e) {
      AppLogger.e('Failed to cache user: $e');
      rethrow;
    }
  }

  // Get cached user with validation
  Future<AuthTokenEntity?> getCachedAuthUser() async {
    try {
      final user = await getCachedResponse<AuthTokenEntity>(
        CacheKeys.USER,
            (json) {
          return  AuthTokenModel.fromJson(json);
            },
        isUser: true
      );

      if (user != null ) {
        return user;
      } else if (user != null) {

        await clearAuthCache();
      }
      return null;
    } catch (e,stackTrace) {
      AppLogger.e('Failed to get cached user: $e $stackTrace');
      return null;
    }
  }
  Future<void> clearAuthCache() async {
    try {
      await removeCacheItem(CacheKeys.USER);
      AppLogger.success('Auth cache cleared successfully');
    } catch (e) {
      AppLogger.e('Failed to clear auth cache: $e');
      rethrow;
    }
  }

  Future<bool> isAuthenticated() async {
    final user = await getCachedAuthUser();
    return user != null;
  }
}