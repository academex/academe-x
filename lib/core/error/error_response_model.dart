// error_response_model.dart
class ErrorResponseModel {
  final List<String>? messages;
  final String? message;
  final String error;
  final int statusCode;

  ErrorResponseModel({
    this.messages,
    this.message,
    required this.error,
    required this.statusCode,
  });

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) {
    return ErrorResponseModel(
      messages: json['message'] is List
          ? List<String>.from(json['message'])
          : null,
      message: json['message'] is String
          ? json['message']
          : null,
      error: json['error'],
      statusCode: json['statusCode'],
    );
  }


}