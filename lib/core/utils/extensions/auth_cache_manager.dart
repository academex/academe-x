import 'dart:convert';
import 'package:academe_x/core/core.dart';
import 'package:academe_x/features/auth/auth.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../constants/cache_keys.dart';

extension AuthCacheManager on HiveCacheManager {
  // Cache the authenticated user
  Future<void> cacheAuthUser(AuthTokenEntity user) async {
    try {
      await cacheResponse<AuthTokenEntity>(
        CacheKeys.USER,
        user,
        duration: const Duration(days: 30), // Or your preferred token lifetime
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
  //
  // // Validate token
  // bool isTokenValid(AuthTokenEntity user) {
  //   if (user.accessToken.isEmpty) {
  //     return false;
  //   }
  //
  //   // Check token expiration if you have expiration in your AuthTokenEntity
  //   try {
  //       final expiryDate = DateTime.now().add(const Duration(hours  : 1));
  //       if (DateTime.now().isAfter(expiryDate)) {
  //         AppLogger.w('Token has expired');
  //         return false;
  //       }
  //
  //     // Add any additional token validation logic here
  //     return true;
  //   } catch (e) {
  //     AppLogger.e('Token validation error: $e');
  //     return false;
  //   }
  // }

  // Clear auth cache
  Future<void> clearAuthCache() async {
    try {
      await removeCacheItem(CacheKeys.USER);
      AppLogger.success('Auth cache cleared successfully');
    } catch (e) {
      AppLogger.e('Failed to clear auth cache: $e');
      rethrow;
    }
  }

  // Check if user is authenticated
  Future<bool> isAuthenticated() async {
    final user = await getCachedAuthUser();
    return user != null;
  }
}