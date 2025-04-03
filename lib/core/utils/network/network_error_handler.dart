// import 'package:dio/dio.dart';
//
// class NetworkErrorHandler {
//   static String handleError(dynamic error) {
//     if (error is DioException) {
//       switch (error.type) {
//         case DioExceptionType.connectionTimeout:
//           return 'انتهت مهلة الاتصال';
//         case DioExceptionType.sendTimeout:
//           return 'انتهت مهلة إرسال البيانات';
//         case DioExceptionType.receiveTimeout:
//           return 'انتهت مهلة استلام البيانات';
//         case DioExceptionType.badResponse:
//           return _handleResponseError(error.response?.statusCode);
//         case DioExceptionType.cancel:
//           return 'تم إلغاء الطلب';
//         default:
//           return 'حدث خطأ في الاتصال';
//       }
//     }
//     return 'حدث خطأ غير متوقع';
//   }
//
//   static String _handleResponseError(int? statusCode) {
//     switch (statusCode) {
//       case 400:
//         return 'طلب غير صالح';
//       case 401:
//         return 'غير مصرح لك بالوصول';
//       case 403:
//         return 'ممنوع الوصول';
//       case 404:
//         return 'لم يتم العثور على البيانات المطلوبة';
//       case 500:
//         return 'خطأ في الخادم';
//       default:
//         return 'حدث خطأ غير متوقع';
//     }
//   }
// }