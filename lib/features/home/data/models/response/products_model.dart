class ProductModel {
  int? id;
  String? name;
  String? slug;
  String? sku;
  String? thumbnail;
  int? inventory;
  double? price;
  double? offerPrice;
  String? description;
  String? category;
  String? brand;
  int? sales;
  String? computedPrice;
  int? isWishlist;
  Null avgRating;
  int? isCart;
  int? inStock;

  ProductModel(
      {this.id,
      this.name,
      this.slug,
      this.sku,
      this.thumbnail,
      this.inventory,
      this.price,
      this.offerPrice,
      this.description,
      this.category,
      this.brand,
      this.sales,
      this.computedPrice,
      this.isWishlist,
      this.avgRating,
      this.isCart,
      this.inStock});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    sku = json['sku'];
    thumbnail = json['thumbnail'];
    inventory = json['inventory'];
    price = json['price'] != null ? double.parse(json['price']) : 0.0;
    offerPrice = json['offer_price'] != null ? double.parse(json['offer_price']) : 0.0;
    description = json['description'];
    category = json['category'];
    brand = json['brand'];
    sales = json['sales'];
    computedPrice = json['computed_price'];
    isWishlist = json['is_wishlist'];
    avgRating = json['avg_rating'];
    isCart = json['is_cart'];
    inStock = json['in_stock'];
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
