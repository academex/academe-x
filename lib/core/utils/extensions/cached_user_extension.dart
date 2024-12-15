import 'package:academe_x/features/college_major/data/models/major_model.dart';
import 'package:flutter/material.dart';

import '../../../features/auth/data/models/response/auth_token_model.dart';
import '../../constants/cache_keys.dart';
import '../../di/dependency_injection.dart';
import '../storage/cache/hive_cache_manager.dart';

extension CachedUserExtension on BuildContext {
  Future<AuthTokenModel?> get cachedUser async {
    return await getIt<HiveCacheManager>().getCachedResponse(
      CacheKeys.USER,
      (json) => AuthTokenModel.fromJson(json),
      isUser: true
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
