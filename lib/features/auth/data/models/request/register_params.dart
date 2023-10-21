class RegisterParams {
  String? email;
  String? firstName;
  String? lastName;
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
    map['firstname'] = firstName;
    map['lastname'] = lastName;
    map['password'] = password;
    map['phoneno'] = contactNumber;

    return map;
  }
}
