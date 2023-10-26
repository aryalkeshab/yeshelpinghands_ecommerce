import '../../../home/data/models/response/products_model.dart';

// class WishList {
//   final String? wishlistItemId;

//   final String? wishlistId;

//   final String? storeId;

//   final ProductModel? product;

//   const WishList(
//       {this.wishlistItemId, this.wishlistId, this.storeId, this.product});

//   factory WishList.fromJson(Map<String, dynamic> json) {
//     return WishList(
//       wishlistItemId: json['wishlist_item_id'],
//       wishlistId: json['220'],
//       storeId: json['store_id'],
//       product: ProductModel.fromJson(json['product']),
//     );
//   }
// }

class WishListProduct {
  String? name;
  String? price;
  String? offerPrice;
  String? slug;
  String? image;
  int? id;
  int? userId;
  int? productId;
  bool? isProductInStock;
  String? createdAt;
  String? updatedAt;

  WishListProduct(
      {this.name,
      this.price,
      this.offerPrice,
      this.slug,
      this.image,
      this.id,
      this.userId,
      this.productId,
      this.isProductInStock,
      this.createdAt,
      this.updatedAt});

  WishListProduct.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    offerPrice = json['offer_price'];
    slug = json['slug'];
    image = json['image'];
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    isProductInStock = json['in_stock'] == 1 ? true : false;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['offer_price'] = this.offerPrice;
    data['slug'] = this.slug;
    data['image'] = this.image;
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
