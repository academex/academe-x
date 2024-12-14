import '../logger.dart';

class AnalyticsService {
  static void logEvent({
    required String name,
    Map<String, dynamic>? parameters,
  }) {
    // Implement your analytics logic (Firebase, Mixpanel, etc.)
    AppLogger.wtf('Event: $name, Params: $parameters');
  }

  static void logScreenView(String screenName) {
    logEvent(
      name: 'screen_view',
      parameters: {'screen_name': screenName},
    );
  }

  static void logUserAction({
    required String action,
    required String itemId,
    String? itemType,
  }) {
    logEvent(
      name: 'user_action',
      parameters: {
        'action': action,
        'item_id': itemId,
        'item_type': itemType,
      },
    );
  }
}