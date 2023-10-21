class EditProfileParams {
  String? name;
  String? contactNumber;

  EditProfileParams({
    this.name,
    this.contactNumber,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['firstname'] = name;
    map['phoneno'] = contactNumber;
    return map;
  }
}
