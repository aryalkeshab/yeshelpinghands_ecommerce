class CountryRegion {
  final String? name;
  final String? code;

  const CountryRegion({this.name, this.code});

  factory CountryRegion.fromJson(Map<String, dynamic> json) {
    return CountryRegion(name: json['name'], code: json['code']);
  }
}
