// class StorageService {
//   final SharedPreferences _prefs;
//
//   StorageService(this._prefs);
//
//   Future<void> saveToken(String token) async {
//     await _prefs.setString('token', token);
//   }
//
//   String? getToken() {
//     return _prefs.getString('token');
//   }
// }