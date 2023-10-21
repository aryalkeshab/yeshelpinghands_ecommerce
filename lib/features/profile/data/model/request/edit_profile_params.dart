class EditProfileParams {
  String? firstName;
  String? lastName;
  String? contactNumber;

  EditProfileParams({
    this.firstName,
    this.lastName,
    this.contactNumber,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['firstname'] = firstName;
    map['lastname'] = lastName;
    map['phoneno'] = contactNumber;
    return map;
  }
}
