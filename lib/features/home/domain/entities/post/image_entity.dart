import 'package:equatable/equatable.dart';

class ImageEntity extends Equatable {
  final int id;
  final String? url;

  const ImageEntity({
    required this.id,
    this.url,
  });

  @override
  List<Object?> get props => [id, url];
}