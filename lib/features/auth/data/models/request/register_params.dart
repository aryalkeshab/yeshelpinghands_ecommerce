class RegisterParams {
  String? email;
  String? name;
  String? username;

  String? password;
  String? confirmPassword;
  String? contactNumber;

  RegisterParams({this.email, this.password});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['name'] = name;
    map['username'] = username;
    map['password'] = password;
    map['mobile'] = contactNumber;
    map["confirm_password"] = confirmPassword;

    return map;
  }
}
