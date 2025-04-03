class LoginRequsetEntity {
  String? username;
  String? password;

  LoginRequsetEntity({String? username, String? password}) {
    if (username != null) {
      this.username = username;
    }
    if (password != null) {
      this.password = password;
    }
  }

  //
  //

}