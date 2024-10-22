class ServerException implements Exception {}

class NoDataException implements Exception {}

class OfflineException implements Exception {
  final String errorMessage;
OfflineException({required this.errorMessage});
}

class SocketException implements Exception {}

class WrongDataException implements Exception {
  final String errorMessage;
  WrongDataException({required this.errorMessage});
}