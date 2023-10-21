class HomeBannerResponse {
  String? bannerImage;
  String? bannerLink;
  String? categoryId;

  HomeBannerResponse({this.bannerImage, this.bannerLink, this.categoryId});

  factory HomeBannerResponse.fromJson(Map<String, dynamic> json) {
    String bannerLink = json['image'];
    // String categoryId = json['category_id'];

    return HomeBannerResponse(bannerLink: bannerLink);
  }
}
