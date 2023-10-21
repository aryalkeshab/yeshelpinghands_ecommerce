import 'package:yeshelpinghand/core/utils/number_parser.dart';

class FilterDrawerModel {
  String? minPrice;
  String? maxPrice;
  Availability? availability;

  List<FilterSubCategory>? subCategories;

  FilterDrawerModel(
      {this.minPrice, this.maxPrice, this.availability, this.subCategories});

  factory FilterDrawerModel.fromJson(Map<String, dynamic> json) {
    return FilterDrawerModel(
      minPrice: json['min_price'],
      maxPrice: json['max_price'],
      availability: json['avaibility'] != null
          ? Availability.fromJson(json['avaibility'])
          : null,
      subCategories: json['subcategories'] != null
          ? json['subcategories']
              .map<FilterSubCategory>((e) => FilterSubCategory.fromJson(e))
              .toList()
          : null,
    );
  }
  factory FilterDrawerModel.init() {
    return FilterDrawerModel(
      minPrice: "0",
      maxPrice: "100000",
      availability: null,
      subCategories: [],
    );
  }

  double get minimumPrice {
    final minValue = NumberParser.doubleFromString(minPrice);
    final maxValue = NumberParser.doubleFromString(maxPrice);

    final minEnd = minValue == maxValue ? 0.0 : minValue;
    return minEnd;
  }

  double get maximumPrice {
    final minValue = NumberParser.doubleFromString(minPrice);
    final maxValue = NumberParser.doubleFromString(maxPrice);

    final maxEnd = minValue == maxValue ? maxValue : maxValue;
    return maxEnd;
  }
}

class Availability {
  String? inStock;
  String? outOfStock;

  Availability({this.inStock, this.outOfStock});

  factory Availability.fromJson(Map<String, dynamic> json) {
    return Availability(
        inStock: json['in_stock'], outOfStock: json['out_of_stock']);
  }
}

class FilterSubCategory {
  String? id;
  String? name;

  FilterSubCategory({this.id, this.name});

  factory FilterSubCategory.fromJson(Map<String, dynamic> json) {
    return FilterSubCategory(
      id: json['id'],
      name: json['category_name'],
    );
  }
}
