class Address {
  int? id;
  String? address;
  String? city;
  String? country;
  String? postalCode;
  String? landmark;
  int? userId;

  Address(
      {this.id,
      this.address,
      this.city,
      this.country,
      this.postalCode,
      this.landmark,
      this.userId});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    city = json['city'];
    country = json['country'];
    postalCode = json['postal_code'];
    landmark = json['landmark'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address'] = this.address;
    data['city'] = this.city;
    data['country'] = this.country;
    data['postal_code'] = this.postalCode;
    data['landmark'] = this.landmark;
    data['user_id'] = this.userId;
    return data;
  }
}
