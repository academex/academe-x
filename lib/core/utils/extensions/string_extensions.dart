// import 'package:intl/intl.dart';
//
// extension StringExtensions on String {
//   String formatDate(String originalDate) {
//     DateTime dateTime = DateTime.parse(originalDate);
//     String formattedDate = DateFormat('dd/MM/yyyy, hh:mm a').format(dateTime);
//     return formattedDate;
//   }
//
//   bool get hasOnlyWhitespaces => trim().isEmpty && isNotEmpty;
//
//   bool get isListView => this != 'horizontal';
//
//   bool get isEmptyOrNull {
//     // ignore: unnecessary_null_comparison
//     if (this == null) {
//       return true;
//     }
//     return isEmpty;
//   }
//
//   String toSpaceSeparated() {
//     final value =
//         replaceAllMapped(RegExp(r'.{4}'), (match) => '${match.group(0)} ');
//     return value;
//   }
//
//   String formatCopy() {
//     return replaceAll('},', '\n},\n')
//         .replaceAll('[{', '[\n{\n')
//         .replaceAll(',"', ',\n"')
//         .replaceAll('{"', '{\n"')
//         .replaceAll('}]', '\n}\n]');
//   }
//
//   bool get isNoInternetError => contains('SocketException: Failed host lookup');
//
//   bool get isURLImage => isNotEmpty && (contains('http') || contains('https'));
//
//   Uri? toUri() => Uri.tryParse(this);
//
//   String capitalize() {
//     return '${this[0].toUpperCase()}${substring(1)}';
//   }
//
//   String upperCaseFirstChar() {
//     return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
//   }
//
//   String toTitleCase() => replaceAll(RegExp(' +'), ' ')
//       .split(' ')
//       .map((str) => str.upperCaseFirstChar())
//       .join(' ');
//
//   RoutingData get getRoutingData {
//     final uriData = Uri.parse(this);
//     return RoutingData(
//       queryParameters: uriData.queryParameters,
//       route: uriData.path,
//     );
//   }
//
//   String handleImage() {
//     return startsWith("http") ? this : "https://livemcards.com$this";
//   }
// }
//
// class RoutingData {
//   final String? route;
//   final Map<String, String>? _queryParameters;
//
//   RoutingData({
//     this.route,
//     Map<String, String>? queryParameters,
//   }) : _queryParameters = queryParameters;
//
//   String? getPram(String key) => _queryParameters![key];
// }
