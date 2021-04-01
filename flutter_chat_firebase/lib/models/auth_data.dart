enum AuthMode { LOGIN, SIGNUP }

class AuthData {
  String name;
  String email;
  String password;
  AuthMode _mode = AuthMode.LOGIN;

  bool get isSignup => _mode == AuthMode.SIGNUP;
  bool get isLogin => _mode == AuthMode.LOGIN;

  void toggleMode() {
    _mode = _mode == AuthMode.LOGIN ? AuthMode.SIGNUP : AuthMode.LOGIN;
  }
}