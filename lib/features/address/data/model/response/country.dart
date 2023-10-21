class Country {
  final String? name;
  final String? code;

  const Country({this.name, this.code});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(name: json['full_name_english'], code: json['id']);
  }
  factory Country.fromJsonForAddress(Map<String, dynamic> json) {
    return Country(name: json['name'], code: json['code']);
  }
}
