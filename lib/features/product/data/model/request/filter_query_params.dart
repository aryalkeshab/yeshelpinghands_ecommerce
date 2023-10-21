class FilterQueryParams {
  FilterQueryParams({
    this.pageSize = 20,
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
      map['searchQuery'] = searchQuery.toString();
    }
    map["searchCriteria[PageSize]"] = pageSize.toString();
    map["searchCriteria[CurrentPage]"] = currentPage.toString();
    if (categoryId != null) map['categoryId'] = categoryId.toString();

    if (brandId != null) map['brandId'] = brandId.toString();
    if (categoryId != null) map['categoryId'] = categoryId.toString();
    if (topRated != null) map['topRated'] = true;
    if (bestSeller != null) map['bestSeller'] = true;
    if (topDeals != null) map['bestDeals'] = true;
    if (sort != null) map['sort'] = sort;
    if (order != null) map['order'] = order;
    if (minPrice != null) map['minPrice'] = minPrice;
    if (maxPrice != null) map['maxPrice'] = maxPrice;
    if (inStock != null) map['instock'] = true;
    if (outOfStock != null) map['outstock'] = true;
    return map;
  }
}
