class User {
  final String? name;
  final String? phoneNumber;
  final String? email;
  final String? profileImage;
  final String? userName;

  User({this.name, this.phoneNumber, this.email, this.profileImage, this.userName});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      phoneNumber: json['mobile'],
      email: json["email"],
      name: json['user_name'],
      userName: json['user_username'],
    );
  }
}
