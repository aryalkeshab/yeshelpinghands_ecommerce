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
    map['mobile'] = contactNumber;
    map['name'] = name;
    map['username'] = userName;
    return map;
  }
}
