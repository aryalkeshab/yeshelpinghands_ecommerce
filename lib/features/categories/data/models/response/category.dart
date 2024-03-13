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

class Category {
  late int id;
  late String name;
  late String slug;
  late int level;
  late int? parentId; // Parent ID can be null
  late String image;
  late int? priority; // Priority can be null
  late int sales;
  late int status;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.level,
    this.parentId,
    required this.image,
    this.priority,
    required this.sales,
    required this.status,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      level: json['level'],
      parentId: json['parent_id'],
      image: json['image'],
      priority: json['priority'],
      sales: json['sales'],
      status: json['status'],
    );
  }
}
