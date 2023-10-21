class ProductDetails {
  String? entityId;
  String? attributeSetId;
  String? typeId;
  String? sku;
  String? hasOptions;
  String? requiredOptions;
  String? createdAt;
  String? updatedAt;
  String? visibility;
  String? brandId;
  String? brandName;
  String? brandDescription;
  String? brandImage;
  String? brandThumbnail;
  String? name;
  String? metaTitle;
  String? metaDescription;
  String? cimCode;
  String? quantityAndStockStatus;
  String? taxClassId;
  String? price;
  String? vatExcludedPrice;
  String? vatAmount;
  int? storeId;
  String? hotOnsale;
  List<Attributes>? attributes;
  int? saleableStock;
  bool? isSaleable;
  ProductImage? image;
  String? availability;
  List<Review>? reviews;
  String? ratingAgg;
  bool? isWishlist;
  bool? isCompared;
  String? navCashbackPoint;

  bool get isProductInStock => availability != 'OUT OF STOCK';
  int? saleableQty;
  List<String>? categoryId;

  int get numericNormalizedAvgRating {
    final normalizedRating = (int.tryParse("$ratingAgg") ?? 20) ~/ 20;
    return normalizedRating;
  }

  ProductDetails(
      {this.entityId,
      this.attributeSetId,
      this.typeId,
      this.sku,
      this.hasOptions,
      this.requiredOptions,
      this.createdAt,
      this.updatedAt,
      this.visibility,
      this.brandId,
      this.brandName,
      this.brandDescription,
      this.brandImage,
      this.brandThumbnail,
      this.name,
      this.metaTitle,
      this.metaDescription,
      this.cimCode,
      this.quantityAndStockStatus,
      this.taxClassId,
      this.price,
      this.vatExcludedPrice,
      this.vatAmount,
      this.storeId,
      this.hotOnsale,
      this.attributes,
      this.saleableStock,
      this.isSaleable,
      this.image,
      this.availability,
      this.reviews,
      this.ratingAgg,
      this.isWishlist,
      this.isCompared,
      this.navCashbackPoint,
      this.saleableQty,
      this.categoryId});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    entityId = json['entity_id'];
    attributeSetId = json['attribute_set_id'];
    typeId = json['type_id'];
    sku = json['sku'];
    hasOptions = json['has_options'];
    requiredOptions = json['required_options'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    visibility = json['visibility'];
    brandId = json['brand_id'];
    brandName = json['brand_name'];
    brandDescription = json['brand_description'];
    brandImage = json['brand_image'];
    brandThumbnail = json['brand_thumbnail'];
    name = json['name'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    cimCode = json['cim_code'];
    quantityAndStockStatus = json['quantity_and_stock_status'];
    taxClassId = json['tax_class_id'];
    price = json['price'];
    vatExcludedPrice = json['vat_excluded_price'];
    vatAmount = json['vat_amount'];
    storeId = json['store_id'];
    hotOnsale = json['hot-onsale'];
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(Attributes.fromJson(v));
      });
    }
    saleableStock = json['saleable_stock'];
    isSaleable = json['is_saleable'];
    image = json['product_images'] != null
        ? ProductImage.fromJson(json['product_images'])
        : null;
    availability = json['availability'];
    if (json['reviews'] != null) {
      reviews = <Review>[];
      json['reviews'].forEach((v) {
        reviews!.add(Review.fromJson(v));
      });
    }
    ratingAgg = json['ratingAgg'];
    isWishlist = json['is_wishlist'];
    isCompared = json['is_compared'];
    navCashbackPoint = json['nav_cashback_point'];
    saleableQty = json['salebaleQty'];
    if (json['category_id'] != null) {
      categoryId = json['category_id'].cast<String>();
    }
  }

  // int get numericPrice => (double.tryParse("$price") ?? 0).toInt();
}

class Attributes {
  String? attributeCode;
  String? attributeValues;

  Attributes({this.attributeCode, this.attributeValues});

  Attributes.fromJson(Map<String, dynamic> json) {
    attributeCode = json['attribute_code'];
    attributeValues = json['attribute_values'];
  }
}

class ProductImage {
  String? image;
  String? thumbnail;
  String? smallImage;

  ProductImage({this.image, this.thumbnail, this.smallImage});

  ProductImage.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    thumbnail = json['thumbnail'];
    smallImage = json['smallImage'];
  }
}

class Review {
  final String? id;
  final String? title;
  final String? details;
  final String? userName;
  final String? createdAt;
  final Ratings? ratings;

  Review(
      {this.id,
      this.title,
      this.details,
      this.userName,
      this.createdAt,
      this.ratings});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['review_id'],
      title: json['title'],
      createdAt: json['created_at'],
      details: json['detail'],
      ratings:
          json['ratings'] != null ? Ratings.fromJson(json['ratings']) : null,
      userName: json['nickname'],
    );
  }
}

class Ratings {
  final String? price;
  final String? quality;
  final String? value;

  Ratings({this.price, this.quality, this.value});

  factory Ratings.fromJson(Map<String, dynamic> json) {
    return Ratings(
      price: json['Price'],
      value: json['Value'],
      quality: json['Quality'],
    );
  }
}
