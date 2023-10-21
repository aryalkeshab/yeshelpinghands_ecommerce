class FeaturedCategoryModel {
  String? categoryName;
  String? categoryId;
  String? categoryImage;

  FeaturedCategoryModel(
      {this.categoryName, this.categoryId, this.categoryImage});

  factory FeaturedCategoryModel.fromJson(Map<String, dynamic> json) {
    String categoryName = json['category_name'];
    String categoryId = json['category_id'];
    String categoryImage = json['category_image'];

    return FeaturedCategoryModel(
        categoryId: categoryId,
        categoryName: categoryName,
        categoryImage: categoryImage);
  }
}
