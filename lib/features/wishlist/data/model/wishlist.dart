
import '../../../home/data/models/response/products_model.dart';

class WishList {
  final String? wishlistItemId;

  final String? wishlistId;

  final String? storeId;

  final ProductModel? product;

  const WishList(
      {this.wishlistItemId, this.wishlistId, this.storeId, this.product});

  factory WishList.fromJson(Map<String, dynamic> json) {
    return WishList(
      wishlistItemId: json['wishlist_item_id'],
      wishlistId: json['220'],
      storeId: json['store_id'],
      product: ProductModel.fromJson(json['product']),
    );
  }
}
