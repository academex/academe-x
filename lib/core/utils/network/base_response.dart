import '../logger.dart';

class BaseResponse<T> {
  final String status;
  final dynamic message;  // Can be String or List<String>
  final T? data;

  BaseResponse({
    required this.status,
    required this.message,
    this.data,
  });

  bool get isSuccess => status.toLowerCase() == 'success';
  bool get isError => status.toLowerCase() == 'error';

  List<String> get messages {
    if (message == null) return [];
    if (message is String) return [message as String];
    if (message is List) return (message as List).map((e) => e.toString()).toList();
    return [];
  }

  factory BaseResponse.fromJson(
      Map<String, dynamic> json,
      T Function(dynamic json) fromJson,
      ) {
    // Handle error response format with statusCode
    if (json.containsKey('statusCode')) {
      return BaseResponse<T>(
        status: 'error',
        message: json['message'] ?? json['error'] ?? 'Unknown error',
        data: null,
      );
    }
    return BaseResponse<T>(
      status: json['status'] ?? 'error',
      message: json['message']?.toString() ?? '',
      data: fromJson(json['data']), // Directly pass the data to fromJson
    );

  }
    Map<String, dynamic> toJson([Map<String, dynamic> Function(T)? toJson]) {
      return {
        'status': status,
        'message': message,
        if (data != null && toJson != null) 'data': toJson(data as T),
      };
    }
}
