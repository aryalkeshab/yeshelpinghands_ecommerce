class FilterQueryParams {
  FilterQueryParams({
    this.pageSize = 10,
    this.searchQuery,
    this.currentPage = 1,
    this.categoryId,
    this.brandId,
    this.newArrival,
    this.topRated,
    this.bestSeller,
    this.topDeals,
    this.sort,
    this.order,
    this.minPrice,
    this.maxPrice,
  });

  int? pageSize;
  String? searchQuery;
  int? currentPage;
  int? categoryId;
  String? brandId;
  bool? newArrival;
  bool? topRated;
  bool? bestSeller;
  bool? topDeals;
  String? sort;
  String? minPrice;
  String? maxPrice;
  bool? inStock;
  bool? outOfStock;
  String? order;

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (searchQuery != null && searchQuery!.isNotEmpty) {
      map['search'] = searchQuery.toString();
    }
    // map["page"] = pageSize.toString();
    // map["current_page"] = currentPage.toString();
    if (categoryId != null) map['categoryId'] = categoryId.toString();

    if (brandId != null) map['brandId'] = brandId.toString();
    if (categoryId != null) map['category_id'] = categoryId.toString();
    // if (topRated != null) map['featured'] = 1;
    // if (bestSeller != null) map['trending'] = 1;
    // if (topDeals != null) map['new'] = 1;
    if (sort != null) map['sort'] = sort;
    if (order != null) map['order'] = order;
    if (minPrice != null) map['min_price'] = minPrice;
    if (maxPrice != null) map['max_price'] = maxPrice;
    if (inStock != null) map['instock'] = true;
    if (outOfStock != null) map['outstock'] = true;
    return map;
  }
}
