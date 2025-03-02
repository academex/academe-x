import 'package:equatable/equatable.dart';
import 'package:academe_x/features/home/domain/entities/post/post_entity.dart';
import 'package:academe_x/features/auth/auth.dart';

enum ProfileStatus { initial, loading, loaded, error }
enum ProfileType { currentUser, otherUser }

class ProfileState extends Equatable {
  // Profile data
  final ProfileStatus status;
  final ProfileType profileType;
  final UserResponseEntity? user;
  final UserResponseEntity? otherUser;
  final String? errorMessage;
  final bool isEditable;
  final bool isLoading;

  // User posts
  final List<PostEntity> posts;
  final bool hasPostsReachedMax;
  final int currentPage;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.profileType = ProfileType.currentUser,
    this.user,
    this.otherUser,
    this.errorMessage,
    this.isEditable = false,
    this.isLoading = false,
    this.posts = const <PostEntity>[],
    this.hasPostsReachedMax = false,
    this.currentPage = 1,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    ProfileType? profileType,
    UserResponseEntity? user,
    UserResponseEntity? otherUser,
    String? errorMessage,
    bool? isEditable,
    bool? isLoading,
    List<PostEntity>? posts,
    bool? hasPostsReachedMax,
    int? currentPage,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profileType: profileType ?? this.profileType,
      user: user,
      otherUser: otherUser ?? this.otherUser,
      errorMessage: errorMessage ?? this.errorMessage,
      isEditable: isEditable ?? this.isEditable,
      isLoading: isLoading ?? this.isLoading,
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
    otherUser,
    errorMessage,
    isEditable,
    isLoading,
    posts,
    hasPostsReachedMax,
    currentPage,
  ];
}