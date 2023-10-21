class Brand {
  String? name;
  String? image;

  Brand({
    this.name,
    this.image,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      name: json['label'],
      image: json['img'],
    );
  }
}
