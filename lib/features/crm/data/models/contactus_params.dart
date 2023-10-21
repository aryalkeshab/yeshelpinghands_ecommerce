class ContactUsparams {
  String? name;
  String? email;
  String? selectedtab;
  String? contactNumber;
  String? description;

  ContactUsparams(
      {this.email,
      this.name,
      this.contactNumber,
      this.description,
      this.selectedtab});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['description'] = description;
    map['contactNumber'] = contactNumber;
    map['email'] = email;
    map['selectedtab'] = selectedtab;

    return {"user": map};
  }
}
