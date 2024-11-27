import 'package:equatable/equatable.dart';

class TagEntity extends Equatable {
  final int id;
  final String name;

  const TagEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}