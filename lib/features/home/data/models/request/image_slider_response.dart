class BannerResponse {
  late String? link;

  BannerResponse({this.link});

  factory BannerResponse.fromJson(Map<String, dynamic> json) {
    String link = json['image'];

    return BannerResponse(link: link);
  }
}
