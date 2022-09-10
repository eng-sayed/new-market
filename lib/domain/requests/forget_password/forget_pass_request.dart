import 'dart:convert';

class ForgetPassRequest {
  String? phone;
  String? password;
  String? passwordconfirmation;
  String? code;

  ForgetPassRequest({
    this.phone,
    this.password,
    this.passwordconfirmation,
    this.code,
  });

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    if (phone != null) {
      result.addAll({'phone': phone});
    }
    if (password != null) {
      result.addAll({'password': password});
    }
    if (passwordconfirmation != null) {
      result.addAll({'password_confirmation': passwordconfirmation});
    }
    if (code != null) {
      result.addAll({'code': code});
    }

    return result;
  }
}
