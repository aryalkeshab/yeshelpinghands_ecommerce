class Category {
  int? id;
  String? image;
  String? name;
  List<SubCategory>? subCategories;

  Category({this.id, this.image, this.name, this.subCategories});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json["name"],
      subCategories: json['children_data']
          ?.map<SubCategory>((e) => SubCategory.fromJson(e))
          .toList(),
    );
  }
}

class SubCategory {
  int? id;
  String? image;
  String? name;
  List<SubCategoryChild>? subCategoryChildren;

  SubCategory({this.id, this.image, this.name, this.subCategoryChildren});

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'],
      name: json["name"],
      subCategoryChildren: json['children_data']
          ?.map<SubCategoryChild>((e) => SubCategoryChild.fromJson(e))
          .toList(),
    );
  }
}

class SubCategoryChild {
  int? id;
  String? image;
  String? name;

  SubCategoryChild({this.id, this.image, this.name});

  factory SubCategoryChild.fromJson(Map<String, dynamic> json) {
    return SubCategoryChild(id: json['id'], name: json["name"]);
  }
}
