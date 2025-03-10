import 'package:academe_x/core/config/app_config.dart';

class ApiSetting {
  static String get baseUrl => AppConfig.apiUrl;

  // Auth endpoints
  static String get login => '${AppConfig.authEndpoint}/signin';
  static String get signup => '${AppConfig.authEndpoint}/signup';
  static String get updateProfile => '${AppConfig.profileEndpoint}/update';

  // tags endpoints
  static String get colleges => '${AppConfig.tagsEndpoint}/colleges';
  static String get majors => '${AppConfig.tagsEndpoint}/majors';


  //
  // // create post
  static String createPost = AppConfig.postsEndpoint;
  static String getTags = AppConfig.getTagsEndpoint;

  static String get getPosts => AppConfig.postsEndpoint;
  static String get getUserPosts => AppConfig.userPostsEndpoint;
  static String get getUser => AppConfig.profileEndpoint;


  static String get getLibrary => AppConfig.libraryEndpoint;

  static String get getComments => AppConfig.postsEndpoint;
  static String get getReplies => AppConfig.commentEndpoint;
  static String get getUserReactionByType => AppConfig.postsEndpoint;
  static String get reactionToPost => AppConfig.postsEndpoint;
}
