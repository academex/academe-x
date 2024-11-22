import 'package:academe_x/core/config/app_config.dart';

class ApiSetting {
  static String get baseUrl => AppConfig.apiUrl;

  // Auth endpoints
  static String get login => '${AppConfig.authEndpoint}/signin';
  static String get signup => '${AppConfig.authEndpoint}/signup';

  // College endpoints
  static String get colleges => '${AppConfig.tagsEndpoint}/colleges';


  //
  // // create post
  static  String createPost = "${baseUrl}post";
}
