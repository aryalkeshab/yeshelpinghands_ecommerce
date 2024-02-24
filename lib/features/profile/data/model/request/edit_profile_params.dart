class EditProfileParams {
  String? name;
  String? contactNumber;
  String? userName;

  EditProfileParams({
    this.name,
    this.contactNumber,
    this.userName,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_name'] = name;
    map['mobile'] = contactNumber;
    map['user_username '] = userName;
    return map;
  }
}
