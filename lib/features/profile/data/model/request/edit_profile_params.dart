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
    map['name'] = name;
    map['mobile'] = contactNumber;
    map['username '] = userName;
    return map;
  }
}
