import 'package:equatable/equatable.dart';
import 'package:academe_x/features/home/domain/entities/post/post_entity.dart';
import 'package:academe_x/features/auth/auth.dart';

enum ProfileStatus { initial, loading, loaded, error }
enum ProfileSavedPostsStatus { initial, loading, loaded, error }
enum ProfileType { currentUser, otherUser }

class ProfileState extends Equatable {
  // Profile data
  final ProfileStatus status;
  final ProfileSavedPostsStatus profileSavedPostsStatus;
  final ProfileType profileType;
  final UserResponseEntity? user;
  final UserResponseEntity? otherUser;
  final String? errorMessage;
  final bool isEditable;
  final bool isLoading;

  // User posts
  final List<PostEntity> posts;
  final List<PostEntity> savedPosts;
  final bool hasPostsReachedMax;
  final bool hasSavedPostsReachedMax;
  final int currentPage;
  final int currentSavedPostsPage;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.profileSavedPostsStatus = ProfileSavedPostsStatus.initial,
    this.profileType = ProfileType.currentUser,
    this.user,
    this.otherUser,
    this.errorMessage,
    this.isEditable = false,
    this.isLoading = false,
    this.posts = const <PostEntity>[],
    this.savedPosts = const <PostEntity>[],
    this.hasPostsReachedMax = false,
    this.hasSavedPostsReachedMax = false,
    this.currentPage = 1,
    this.currentSavedPostsPage = 1,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    ProfileSavedPostsStatus? profileSavedPostsStatus,
    ProfileType? profileType,
    UserResponseEntity? user,
    UserResponseEntity? otherUser,
    String? errorMessage,
    bool? isEditable,
    bool? isLoading,
    List<PostEntity>? posts,
    List<PostEntity>? savedPosts,
    bool? hasPostsReachedMax,
    bool? hasSavedPostsReachedMax,
    int? currentPage,
    int? currentSavedPostsPage,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profileSavedPostsStatus: profileSavedPostsStatus ?? this.profileSavedPostsStatus,
      profileType: profileType ?? this.profileType,
      user: user ?? this.user,
      otherUser: otherUser ?? this.otherUser,
      errorMessage: errorMessage ?? this.errorMessage,
      isEditable: isEditable ?? this.isEditable,
      isLoading: isLoading ?? this.isLoading,
      posts: posts ?? this.posts,
      savedPosts: savedPosts ?? this.savedPosts,
      hasPostsReachedMax: hasPostsReachedMax ?? this.hasPostsReachedMax,
      hasSavedPostsReachedMax: hasSavedPostsReachedMax ?? this.hasSavedPostsReachedMax,
      currentPage: currentPage ?? this.currentPage,
      currentSavedPostsPage: currentSavedPostsPage ?? this.currentSavedPostsPage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    profileSavedPostsStatus,
    profileType,
    user,
    otherUser,
    errorMessage,
    isEditable,
    isLoading,
    posts,
    savedPosts,
    hasPostsReachedMax,
    hasSavedPostsReachedMax,
    currentPage,
    currentSavedPostsPage,
  ];
}