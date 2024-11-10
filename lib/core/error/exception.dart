class ServerException implements Exception {}

class NoDataException implements Exception {}

<<<<<<< HEAD
class OfflineException implements Exception {
  final String errorMessage;
OfflineException({required this.errorMessage});
}

class TimeOutExeption implements Exception {
  final String errorMessage;
  TimeOutExeption({required this.errorMessage});

}

class WrongDataException implements Exception {
  final String errorMessage;
  WrongDataException({required this.errorMessage});
}
=======
class OfflineException implements Exception {}

class SocketException implements Exception {}

class WrongDataException implements Exception {}
>>>>>>> 536135a (Description of changes)
