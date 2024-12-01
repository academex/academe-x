import 'package:academe_x/features/home/domain/entities/post/tag_entity.dart';

abstract class GetTagsState {}

class GetTagsLoading extends GetTagsState {}

class GetTagsError extends GetTagsState {
  final String errorMessage;
  GetTagsError({required this.errorMessage});
}

class GetTagsSuccessful extends GetTagsState {
  final List<TagEntity> tags;
  GetTagsSuccessful({required this.tags});
}

class GetTagsInit extends GetTagsState {}
