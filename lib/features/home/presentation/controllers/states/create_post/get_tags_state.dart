import 'package:academe_x/features/college_major/domain/entities/major_entity.dart';


abstract class GetTagsState {}

class GetTagsLoading extends GetTagsState {}

class GetTagsError extends GetTagsState {
  final String errorMessage;
  GetTagsError({required this.errorMessage});
}

class GetTagsSuccessful extends GetTagsState {
  final List<MajorEntity> tags;
  GetTagsSuccessful({required this.tags});
}

class GetTagsInit extends GetTagsState {}
