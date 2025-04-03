import 'package:equatable/equatable.dart';

class SaveResponseEntity extends Equatable {
  final int? id;
  final int? userId;
  final int? postId;

  const SaveResponseEntity({
    this.id,
    this.postId,
    this.userId,
  });

  @override
  List<Object?> get props => [id,postId,userId];
}