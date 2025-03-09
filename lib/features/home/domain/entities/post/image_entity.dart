import 'package:equatable/equatable.dart';

class ImageEntity extends Equatable {
  final int? id;
  final String? url;
  final String? name;

  const ImageEntity({
    this.id,
    this.url,
    this.name,
  });

  @override
  List<Object?> get props => [id, url,name];
}