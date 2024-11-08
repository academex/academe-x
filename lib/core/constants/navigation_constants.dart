import 'app_assets.dart';

abstract class NavigationIndex {
  static const int community = 0;
  static const int library = 1;
  static const int chat = 2;
  static const int profile = 3;
}

class NavigationItem {
  final String label;
  final String icon;
  // final String activeIcon;

  const NavigationItem({
    required this.label,
    required this.icon,
    // required this.activeIcon,
  });
}

class NavigationItems {
  static List<NavigationItem> items = [
    const NavigationItem(
      label: 'مجتمعي',
      icon: AppAssets.communityInactive,
      // activeIcon: AppAssets.communityActive,
    ),
    const NavigationItem(
      label: 'مكتبتي',
      icon: AppAssets.libraryInactive,
      // activeIcon: AppAssets.libraryActive,
    ),
    const NavigationItem(
      label: 'create',
      icon: AppAssets.libraryInactive,
      // activeIcon: AppAssets.libraryActive,
    ),
    const NavigationItem(
      label: 'شات بوت',
      icon: AppAssets.chatInactive,
      // activeIcon: AppAssets.chatActive,
    ),
    const NavigationItem(
      label: 'الاعدادات',
      icon: AppAssets.settingsInactive,
      // activeIcon: AppAssets.settingsActive,
    ),
  ];
}