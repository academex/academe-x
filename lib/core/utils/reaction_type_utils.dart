import 'package:academe_x/core/constants/app_assets.dart';

class ReactionTypeUtils {
  static String getIconPath(String type) {
    switch (type.toUpperCase()) {
      case 'QUESTION':
        return AppAssets.question;
      case 'HEART':
        return AppAssets.heart;
      case 'INSIGHTFUL':
        return AppAssets.insightful;
      case 'FUNNY':
        return AppAssets.funny;
      case 'CELEBRATE':
        return AppAssets.celebrate;
      default:
        return AppAssets.heart;
    }
  }
}