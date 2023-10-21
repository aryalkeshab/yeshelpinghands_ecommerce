class RegisterParams {
  String? email;
  String? name;
  String? username;

  String? password;
  String? confirmPassword;
  String? contactNumber;

  RegisterParams({this.email, this.password});

/*
{
    "email":"someone@example.com",
    "firstname":"firstname",
    "lastname":"lastname",
    "password":"Password1",
    "companyBrn":"example",
    "mobile":"9876564567",
    "nationalId":"example"
}
 */
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
