import 'package:equatable/equatable.dart';
import 'package:academe_x/features/home/domain/entities/post/post_entity.dart';
import 'package:academe_x/features/auth/auth.dart';

enum ProfileStatus { initial, loading, loaded, error }
enum ProfileType { currentUser, otherUser }

class ProfileState extends Equatable {
  // Profile data
  final ProfileStatus status;
  final ProfileType profileType;
  final AuthTokenModel? user;
  final String? errorMessage;
  final bool isEditable;

  // User posts
  final List<PostEntity> posts;
  final bool hasPostsReachedMax;
  final int currentPage;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.profileType = ProfileType.currentUser,
    this.user,
    this.errorMessage,
    this.isEditable = false,
    this.posts = const <PostEntity>[],
    this.hasPostsReachedMax = false,
    this.currentPage = 1,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    ProfileType? profileType,
    AuthTokenModel? user,
    String? errorMessage,
    bool? isEditable,
    List<PostEntity>? posts,
    bool? hasPostsReachedMax,
    int? currentPage,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profileType: profileType ?? this.profileType,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      isEditable: isEditable ?? this.isEditable,
      posts: posts ?? this.posts,
      hasPostsReachedMax: hasPostsReachedMax ?? this.hasPostsReachedMax,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    profileType,
    user,
    errorMessage,
    isEditable,
    posts,
    hasPostsReachedMax,
    currentPage,
  ];
}