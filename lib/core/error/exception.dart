
class NoDataException implements Exception {}



class ValidationException implements Exception {
  final List<String> messages;
  ValidationException({required this.messages});
}

class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException({required this.message});
}
class NotFoundException implements Exception {
  final String message;
  NotFoundException({required this.message});
}
class ForbiddenException implements Exception {
  final String message;
  ForbiddenException({required this.message});
}
class TooManyRequestsException implements Exception {
  final String message;
  TooManyRequestsException({required this.message});
}



class ServerException implements Exception {
  final String message;
  ServerException({required this.message});
}

class OfflineException implements Exception {
  final String errorMessage;
OfflineException({required this.errorMessage});
}

class TimeOutExeption implements Exception {
  final String errorMessage;
  TimeOutExeption({required this.errorMessage});

}
