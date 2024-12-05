import 'package:academe_x/features/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../features/auth/data/models/response/auth_token_model.dart';
import '../../constants/cache_keys.dart';
import '../../di/dependency_injection.dart';
import '../../storage/cache/hive_cache_manager.dart';

// Extension on BuildContext to easily access cached user
extension CachedUserExtension on BuildContext {
  Future<AuthTokenModel?> get cachedUser async {
    return await getIt<HiveCacheManager>().getCachedResponse(
      CacheKeys.USER,
      (json) => AuthTokenModel.fromJson(json),
    );
  }

  Future<List<MajorModel>?> get cachMajor async {
    return await getIt<HiveCacheManager>().getCachedResponse(CacheKeys.MAJORS,
        (json) {
      return (json as List)
          .map(
            (e) => MajorModel.fromJson(e),
          )
          .toList();
    });
  }
}
