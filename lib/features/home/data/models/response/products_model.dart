// class ProductModel {
//   late int id;
//   late String name;
//   late String slug;
//   late String sku;
//   late String thumbnail;
//   late int inventory;
//   late double price;
//   late double offerPrice;
//   late String description;
//   // late String createdAt;
//   late String category;
//   late String brand;
//   late double computedPrice;
//   late int isWishlist;
//   late double? avgRating;
//   late bool isProductInStock;

//   ProductModel({
//     required this.id,
//     required this.name,
//     required this.slug,
//     required this.sku,
//     required this.thumbnail,
//     required this.inventory,
//     required this.price,
//     required this.offerPrice,
//     required this.description,
//     // required this.createdAt,
//     required this.category,
//     required this.brand,
//     required this.computedPrice,
//     required this.isWishlist,
//     this.avgRating,
//     this.isProductInStock = true,
//   });

//   factory ProductModel.fromJson(Map<String, dynamic> json) {
//     return ProductModel(
//       id: json['id'],
//       name: json['name'],
//       slug: json['slug'],
//       sku: json['sku'],
//       thumbnail: json['thumbnail'],
//       inventory: json['inventory'],

//       price: json['price'] != null ? double.parse(json['price']) : 0.0,
//       offerPrice:
//           json['offer_price'] != null ? double.parse(json['offer_price']) : 0.0,
//       description: json['description'],
//       // createdAt: json['created_at'],
//       category: json['category'],
//       brand: json['brand'],
//       computedPrice: json['computed_price'] != null
//           ? double.parse(json['computed_price'])
//           : 0.0,
//       isWishlist: json['is_wishlist'],
//       isProductInStock: json["in_stock"] == 1 ? true : false,
//       avgRating:
//           json['avg_rating'] != null ? double.parse(json['avg_rating']) : null,
//     );
//   }
// }
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
  Null? avgRating;
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
    offerPrice =
        json['offer_price'] != null ? double.parse(json['offer_price']) : 0.0;
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

/*
 "image_gallery": {
                    "image": "/e/l/electronics_-_scanfrost_sfr300-refrigerator_frost_free_silver_-_300l_itm002319_.jpg",
                    "thumbnail": "/e/l/electronics_-_scanfrost_sfr300-refrigerator_frost_free_silver_-_300l_itm002319_.jpg",
                    "small_image": "/e/l/electronics_-_scanfrost_sfr300-refrigerator_frost_free_silver_-_300l_itm002319_.jpg"
                }
 */
