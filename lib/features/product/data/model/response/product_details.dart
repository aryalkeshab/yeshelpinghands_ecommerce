class ProductDetails {
  int? id;
  String? name;
  String? slug;
  String? sku;
  String? thumbnail;
  int? inventory;
  String? price;
  String? offerPrice;
  String? description;
  String? createdAt;
  String? category;
  String? brand;
  String? computedPrice;
  bool? isWishlist;
  bool? isCart;
  int? avgRating;
  bool? inStock;
  List<AdditionalImages>? additionalImages;
  List<Reviews>? reviews;

  ProductDetails(
      {this.id,
      this.name,
      this.slug,
      this.sku,
      this.thumbnail,
      this.inventory,
      this.price,
      this.offerPrice,
      this.description,
      this.createdAt,
      this.category,
      this.brand,
      this.computedPrice,
      this.isWishlist,
      this.avgRating,
      this.inStock,
      this.additionalImages,
      this.reviews,
      this.isCart});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    sku = json['sku'];
    thumbnail = json['thumbnail'];
    inventory = json['inventory'];
    price = json['price'];
    offerPrice = json['offer_price'];
    description = json['description'];
    createdAt = json['created_at'];
    category = json['category'];
    brand = json['brand'];
    computedPrice = json['computed_price'];
    isWishlist = json['is_wishlist'] == 1 ? true : false;
    avgRating = json['avg_rating'];
    inStock = json['in_stock'] == 1 ? true : false;
    isCart = json['in_cart'] == 1 ? true : false;
    if (json['additional_images'] != null) {
      additionalImages = <AdditionalImages>[];
      json['additional_images'].forEach((v) {
        additionalImages!.add(new AdditionalImages.fromJson(v));
      });
    }
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['sku'] = this.sku;
    data['thumbnail'] = this.thumbnail;
    data['inventory'] = this.inventory;
    data['price'] = this.price;
    data['offer_price'] = this.offerPrice;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['category'] = this.category;
    data['brand'] = this.brand;
    data['computed_price'] = this.computedPrice;
    data['is_wishlist'] = this.isWishlist;
    data['avg_rating'] = this.avgRating;
    data['in_stock'] = this.inStock;
    if (this.additionalImages != null) {
      data['additional_images'] =
          this.additionalImages!.map((v) => v.toJson()).toList();
    }
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AdditionalImages {
  int? id;
  String? image;
  String? thumbnail;
  String? altText;
  int? productId;

  AdditionalImages({
    this.id,
    this.image,
    this.thumbnail,
    this.altText,
    this.productId,
  });

  AdditionalImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    thumbnail = json['thumbnail'];
    altText = json['alt_text'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['thumbnail'] = this.thumbnail;
    data['alt_text'] = this.altText;
    data['product_id'] = this.productId;

    return data;
  }
}

class Reviews {
  int? id;
  int? userId;
  int? productId;
  String? review;
  String? reviewImage;
  String? created_at;

  int? rating;
  String? uName;
  String? uImage;

  Reviews(
      {this.id,
      this.userId,
      this.productId,
      this.review,
      this.reviewImage,
      this.rating,
      this.uName,
      this.created_at,
      this.uImage});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    review = json['review'];
    reviewImage = json['review_image'];

    rating = json['rating'];
    created_at = json['created_at'];
    uName = json['u_name'];
    uImage = json['u_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['review'] = this.review;
    data['review_image'] = this.reviewImage;

    data['rating'] = this.rating;
    data['u_name'] = this.uName;
    data['u_image'] = this.uImage;
    return data;
  }
}
