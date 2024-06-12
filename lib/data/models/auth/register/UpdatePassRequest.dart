class UpdatePassRequest {
  UpdatePassRequest({
    this.password,
    this.passwordConfirmation,
  });

  String? password;
  String? passwordConfirmation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['current_password'] = password;
    map['new_password'] = passwordConfirmation;

    return map;
  }
}
