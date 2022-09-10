import 'dart:convert';

class RegisterRequest {
  String? phone;
  String? password;
  String? mobileToken;
  String? name;
  String? email;
  String? passwordConfirmation;
  String? code;
  RegisterRequest({
    this.phone,
    this.password,
    this.mobileToken,
    this.name,
    this.email,
    this.passwordConfirmation,
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
    if (mobileToken != null) {
      result.addAll({'mobile_token': mobileToken});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (passwordConfirmation != null) {
      result.addAll({'password_confirmation': passwordConfirmation});
    }
    if (code != null) {
      result.addAll({'code': code});
    }

    return result;
  }
}
