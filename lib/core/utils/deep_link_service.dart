import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../academeX_main.dart';

class DeepLinkService {
  static final AppLinks _appLinks = AppLinks();

  // Initialize deep link handling
  static Future<void> initialize() async {
    // Handle initial link if app was launched from terminated state
    try {
      final Uri? initialLink = await _appLinks.getInitialLink();
      if (initialLink != null) {
        _handleDeepLink(initialLink);
      }
    } catch (e) {
      print('Error getting initial link: $e');
    }

    // Handle links when app is in background or foreground
    _appLinks.uriLinkStream.listen(
          (Uri? uri) {
        if (uri != null) {
          _handleDeepLink(uri);
        }
      },
      onError: (err) {
        print('Error handling deep link: $err');
      },
    );
  }

  static void _handleDeepLink(Uri uri) {
    final pathSegments = uri.pathSegments;

    if (pathSegments.isNotEmpty && pathSegments[0] == 'post') {
      final String postId = pathSegments[1];
       NavigationService.navigatorKey.currentContext!.go('/post/$postId');
    }
  }
}