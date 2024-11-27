import 'package:equatable/equatable.dart';

class FileInfo extends Equatable {
  final String? url;
  final String? name;

  const FileInfo({
    this.url,
    this.name,
  });

  @override
  List<Object?> get props => [url, name];
}