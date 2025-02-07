import 'dart:async';
import 'dart:convert';
import 'package:academe_x/core/utils/network/base_response.dart';
import 'package:academe_x/core/pagination/paginated_meta.dart';
import 'package:academe_x/core/utils/extensions/cached_user_extension.dart';
import 'package:academe_x/features/home/data/datasources/create_post/create_post_remote_data_source.dart';
import 'package:academe_x/features/home/data/models/post/comment_model.dart';
import 'package:academe_x/features/home/data/models/post/post_model.dart';
import 'package:academe_x/features/home/data/models/post/reaction_item_model.dart';
import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:academe_x/lib.dart';
import 'package:logger/logger.dart';

import '../../../../core/pagination/paginated_response.dart';
import '../../../../core/pagination/pagination_params.dart';
import '../../../../core/utils/handle_http_error.dart';
import '../../../../core/utils/network/api_controller.dart';
import '../../../../core/utils/network/api_setting.dart';
import '../../domain/entities/post/reaction_item_entity.dart';
import '../models/post/save_response_model.dart';

typedef PostsResponse = BaseResponse<PaginatedResponse<List<PostModel>>>;
typedef SaveResponse = BaseResponse<SaveResponseModel>;
typedef CreatePostBaseResponse = BaseResponse<CommentModel>;

class PostRemoteDataSource {
  final ApiController apiController;
  final InternetConnectionChecker internetConnectionChecker;

  PostRemoteDataSource(
      {required this.apiController, required this.internetConnectionChecker});

  Future<PaginatedResponse<PostModel>> getPosts(
      PaginationParams paginationParams) async {
    String url =
        '${ApiSetting.getPosts}?tagId=${paginationParams.tagId}&page=${paginationParams.page}';
    // if(paginationParams.userName != null){
    //   url = ApiSetting.getUserPosts+paginationParams.userName!;
    // }
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${(await NavigationService.navigatorKey.currentContext!.cachedUser)!.accessToken}'
          },
        );
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }

        final baseResponse =
            BaseResponse<PaginatedResponse<PostModel>>.fromJson(
          responseBody,
          (json) {
            return PaginatedResponse<PostModel>.fromJson(
              json,
              (p0) {
                return PostModel.fromJson(p0);
              },
            );
          },
        );
        return baseResponse.data!;
      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  Future<PaginatedResponse<PostModel>> loadProfilePosts(
      PaginationParams paginationParams) async {
    String url =
        '${ApiSetting.getUserPosts}/${paginationParams.username}?page=${paginationParams.page}';
    // if(paginationParams.userName != null){
    //   url = ApiSetting.getUserPosts+paginationParams.userName!;
    // }
    if (await internetConnectionChecker.hasConnection) {
      try {
        AppLogger.network(url);
        final response = await apiController.get(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
            'Bearer ${(await NavigationService.navigatorKey.currentContext!.cachedUser)!.accessToken}'
          },
        );
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }

        final baseResponse =
        BaseResponse<PaginatedResponse<PostModel>>.fromJson(
          responseBody,
              (json) {
            return PaginatedResponse<PostModel>.fromJson(
              json,
                  (p0) {
                return PostModel.fromJson(p0);
              },
            );
          },
        );
        return baseResponse.data!;
      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  Future<PaginatedResponse<CommentModel>> getComments(
      {required PaginationParams paginationParams, required int postId}) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        Logger().d(postId);
        final response = await apiController.get(
          Uri.parse(
              '${ApiSetting.getComments}/$postId/comment?limit=${paginationParams.limit}&page=${paginationParams.page}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${(await NavigationService.navigatorKey.currentContext!.cachedUser)!.accessToken}'
          },
        );
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }
        final baseResponse =
            BaseResponse<PaginatedResponse<CommentModel>>.fromJson(
          responseBody,
          (json) {
            return PaginatedResponse<CommentModel>.fromJson(
              json,
              (p0) {
                return CommentModel.fromJson(p0);
              },
            );
          },
        );

        // Logger().d(baseResponse.data!.items);
        return baseResponse.data!;
      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  Future<BaseResponse<PostModel>> getPostDetails(
      PaginationParams paginationParams) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse('${ApiSetting.getPosts}/${paginationParams.postId}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${(await NavigationService.navigatorKey.currentContext!.cachedUser)!.accessToken}'
          },
        );
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }

        final baseResponse = BaseResponse<PostModel>.fromJson(
          responseBody,
          (json) {
            return PostModel.fromJson(json);
          },
        );
        return baseResponse;
      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  Future<PaginatedResponse<ReactionItemModel>> getReactions(
      PaginationParams paginationParams, String reactType, int postId) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse(
              '${ApiSetting.getUserReactionByType}/$postId/reactions?page=${paginationParams.page}&type=$reactType'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${(await NavigationService.navigatorKey.currentContext!.cachedUser)!.accessToken}'
          },
        );
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }

        final baseResponse =
            BaseResponse<PaginatedResponse<ReactionItemModel>>.fromJson(
          responseBody,
          (json) {
            return PaginatedResponse<ReactionItemModel>.fromJson(
              json,
              (p0) {
                return ReactionItemModel.fromJson(p0);
              },
            );
          },
        );
        return baseResponse.data!;
      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  Future<BaseResponse<void>> reactToPost(
      String reactionType, int postId) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController
            .post(Uri.parse('${ApiSetting.getPosts}/$postId/react'), headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer ${(await NavigationService.navigatorKey.currentContext!.cachedUser)!.accessToken}'
        }, body: {
          "type": reactionType.toUpperCase()
        });
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }

        final baseResponse = BaseResponse<void>.fromJson(
          responseBody,
          (json) {},
        );

        return baseResponse;
      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  Future<BaseResponse<SaveResponseModel>> savePost(int postId) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse('${ApiSetting.getPosts}/$postId/save'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer ${(await NavigationService.navigatorKey.currentContext!.cachedUser)!.accessToken}'
          },
        );
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }
        if (response.statusCode == 200 || responseBody['data'] == null) {}
        final baseResponse = SaveResponse.fromJson(
          responseBody,
          (json) {
            return SaveResponseModel.fromJson(json as Map<String, dynamic>?);
          },
        );

        return baseResponse;
      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  // void _handleHttpError(Map<String,dynamic> json) {
  //   // Handle error response format with statusCode field
  //   if (json.containsKey('statusCode')) {
  //     final errorResponse = ErrorResponseModel.fromJson(json);
  //
  //     switch (errorResponse.statusCode) {
  //       case 400:
  //         final messages = errorResponse.messages ??
  //             [errorResponse.message ?? ''];
  //         throw ValidationException(messages: messages);
  //       case 401:
  //         throw UnauthorizedException(
  //           message: errorResponse.message ?? 'Unauthorized',
  //         );
  //         case 403:
  //         throw UnauthorizedException(
  //           message: errorResponse.message ?? 'Unauthorized',
  //         );
  //       case 500:
  //       case 502:
  //       case 503:
  //       case 504:
  //         throw ServerException(
  //           message: errorResponse.message ?? 'Server error (${errorResponse.statusCode})',
  //         );
  //       default:
  //         throw ServerException(
  //           message: errorResponse.message ?? 'Server error',
  //         );
  //     }
  //   }else{
  //     if (json['status'] =='error') {
  //       AppLogger.e('Login Error: ${json['status']}');
  //       if (json['message'] is List) {
  //         final List<String> messages = (json['message'] as List)
  //             .map((e) => e.toString())
  //             .toList();
  //         throw ValidationException(messages: messages);
  //       }
  //       throw ValidationException(
  //         messages: [json['message'].toString() ?? 'Unknown error'],
  //       );
  //     }
  //   }
  // }

  Future<CreatePostBaseResponse> createComment(
      {required int postId, required String content}) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        // Logger().d(postId);
        final response = await apiController.post(
          Uri.parse(
              '${ApiSetting.getComments}/$postId/comment/'), // /post/2/comment/
          headers: {
            'Authorization':
                'Bearer ${(await NavigationService.navigatorKey.currentContext!.cachedUser)!.accessToken}',
          },
          body: {'content': content},
        );
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }
        UserResponseEntity? user =
            (await NavigationService.navigatorKey.currentContext!.cachedUser)!
                .user;
        final baseResponse = CreatePostBaseResponse.fromJson(
          responseBody,
          (json) {
            return CommentModel.fromJson(json, user: user);
          },
        );

        // Logger().d(baseResponse.data!.items);
        return baseResponse;
      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  Future<CreatePostBaseResponse> updateComment(
      {required int postId,
      required String content,
      required int commentId}) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        Logger().d(postId);
        final response = await apiController.put(
          Uri.parse(
              '${ApiSetting.getComments}/$postId/comment/$commentId'), // /post/2/comment/2
          headers: {
            'Authorization':
                'Bearer ${(await NavigationService.navigatorKey.currentContext!.cachedUser)!.accessToken}',
          },
          body: {'content': content},
        );
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }
        UserResponseEntity? user =
            (await NavigationService.navigatorKey.currentContext!.cachedUser)!
                .user;
        final baseResponse = CreatePostBaseResponse.fromJson(
          responseBody,
          (json) {
            return CommentModel.fromJson(json, user: user);
          },
        );

        // Logger().d(baseResponse.data!.items);
        return baseResponse;
      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  Future<Unit> deleteComment(
      {required int postId, required int commentId}) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        Logger().d(postId);
        final response = await apiController.delete(
          Uri.parse(
              '${ApiSetting.getComments}/$postId/comment/$commentId'), // /post/2/comment/
          headers: {
            'Authorization':
                'Bearer ${(await NavigationService.navigatorKey.currentContext!.cachedUser)!.accessToken}',
            "Content-Type": "application/json",
          },
        );
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }
        return unit;
      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  Future<BaseResponse<CommentModel>> createReply(
      {required int commentId, int? parentId, required String content}) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.post(
          Uri.parse(
              '${ApiSetting.getReplies}/$commentId/reply'), // /post/2/comment/
          headers: {
            'Authorization':
                'Bearer ${(await NavigationService.navigatorKey.currentContext!.cachedUser)!.accessToken}',
          },
          body: {
            "content": content,
            "parentId": parentId,
          },
        );
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }
        final baseResponse = BaseResponse<CommentModel>.fromJson(
          responseBody,
          (json) {
            return CommentModel.fromJson(json);
          },
        );
        return baseResponse;
      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  Future<BaseResponse<List<CommentModel>>> getReplies(
      {required int commentId}) async {
    if (await internetConnectionChecker.hasConnection) {
      try {
        final response = await apiController.get(
          Uri.parse(
              '${ApiSetting.getReplies}/$commentId/reply'), // /post/2/comment/
          headers: {
            'Authorization':
                'Bearer ${(await NavigationService.navigatorKey.currentContext!.cachedUser)!.accessToken}',
          },
        );
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }
        final baseResponse = BaseResponse<List<CommentModel>>.fromJson(
          responseBody,
          (json) {
            return (json as List)
                .map(
                  (e) => CommentModel.fromJson(e),
                )
                .toList();
          },
        );
        return baseResponse;
      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }

  Future<BaseResponse<void>> likeOnCommentOrReply(
      {required int commentId, int? postId, int? replyId}) async {
    if (postId == null && replyId == null) {
      throw Exception('Either post Id or reply Id is required');
    }
    if (await internetConnectionChecker.hasConnection) {
      try {
        Uri url;
        if (postId != null) {
          url = Uri.parse(
              '${ApiSetting.getComments}/$postId/comment/$commentId/like'); // /post/1/comment/1/like
        } else {
          url = Uri.parse(
              '${ApiSetting.getReplies}/$commentId/reply/$replyId/like'); // /comment/1/reply/1/like
        }

        final response = await apiController.get(
          url,
          headers: {
            'Authorization':
                'Bearer ${(await NavigationService.navigatorKey.currentContext!.cachedUser)!.accessToken}',
          },
        );
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        if (response.statusCode >= 400) {
          HandleHttpError.handleHttpError(responseBody);
        }
        final baseResponse = BaseResponse<void>.fromJson(
          responseBody,
          (json) {},
        );
        return baseResponse;
      } on TimeOutExeption {
        rethrow;
      }
    } else {
      throw OfflineException(errorMessage: 'No Internet Connection');
    }
  }
}
