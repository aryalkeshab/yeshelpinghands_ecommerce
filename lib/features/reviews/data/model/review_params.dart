class ReviewParams {
  int priceRating;
  int qualityRating;

  int valueRating;

  String? nickname;
  String? summary;
  String? review;

  ReviewParams(
      {this.priceRating = 1,
      this.qualityRating = 1,
      this.valueRating = 1,
      this.nickname,
      this.summary,
      this.review});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['price'] = priceRating;
    map['quality'] = qualityRating;
    map['value'] = valueRating;
    map['nickname'] = nickname;
    map['title'] = summary;
    map['detail'] = review;
    return map;
  }
}
