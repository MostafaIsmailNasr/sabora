
enum AuthStatus { login, go_step_2,go_step_3 }

extension LoginStatus on AuthStatus {

  dynamic get status {
    switch (this) {
      case AuthStatus.login:
        return "login";
      case AuthStatus.go_step_2:
        return "go_step_2";
      case AuthStatus.go_step_3:
        return "go_step_3";
    }
  }
}
