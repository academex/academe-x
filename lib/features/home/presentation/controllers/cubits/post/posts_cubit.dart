import 'package:academe_x/features/features.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/pagination/pagination_params.dart';
import '../../../../data/models/post/post_model.dart';
import '../../../../domain/entities/post/post_entity.dart';
import '../../states/post/post_state.dart';



class PostsCubit extends Cubit<PostsState> {
  final PostUseCase getPosts;

  PostsCubit({
    required this.getPosts,
  }) : super( PostsState());

  Future<void> loadPosts({bool refresh = false}) async {
    if (state.hasReachedMax && !refresh) return;
    if (state.isLoadingPosts) return;

    try {
    emit( state.copyWith(isLoadingPosts: true,));
      // If refreshing or initial load, start from page 1
      final page = refresh ? 1 : state.currentPage;

      // Show loading state only for initial load
      if (state.status == PostStatus.initial) {
        emit(state.copyWith(status: PostStatus.loading));
      }

      final result = await getPosts.getPosts(PaginationParams(page: page));

      result.fold(
            (failure) {
          emit(state.copyWith(
            isLoadingPosts: false,
            status: PostStatus.failure,
            errorMessage: failure.message,
          ));
        },
            (paginatedData) {
          final newPosts = refresh
              ? paginatedData.items
              : [...state.posts, ...paginatedData.items];

          emit(state.copyWith(
            isLoadingPosts: false,
            status: PostStatus.success,
            posts: newPosts as List<PostEntity>,
            hasReachedMax: !paginatedData.hasNextPage,
            currentPage: refresh ? 2 : state.currentPage + 1,
            errorMessage: null,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        isLoadingPosts: false,
        status: PostStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> refreshPosts() async {
    emit(state.copyWith(
      status: PostStatus.loading,
      posts: [],
      hasReachedMax: false,
      currentPage: 1,
    ));
    await loadPosts(refresh: true);
  }
}