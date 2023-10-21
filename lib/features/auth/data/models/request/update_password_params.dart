class UpdatePasswordParams {
  String? currentPassword;
  String? newPassword;

  UpdatePasswordParams({this.currentPassword, this.newPassword});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currentPassword'] = currentPassword;
    map['newPassword'] = newPassword;
    return map;
  }
}
