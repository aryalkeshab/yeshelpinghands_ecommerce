import 'package:yeshelpinghand/core/utils/number_parser.dart';

class CartResponse {
  CartDetail? cartDetail;

  CartResponse({required this.cartDetail});

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
        cartDetail: json['cart'] != null
            ? CartDetail.fromJson(json['cart'])
            : CartDetail.init());
  }

  factory CartResponse.init() {
    return CartResponse(cartDetail: CartDetail.init());
  }
}

class CartDetail {
  String? quoteId;
  String? customerId;
  String? storeId;
  String? isActive;
  int? itemsCount;
  int? itemsQty;
  int? grandTotal;
  int? subtotal;
  int? subtotalWithDiscount;
  List<CartItem>? items;

  CartDetail(
      {this.quoteId,
      this.customerId,
      this.storeId,
      this.isActive,
      this.itemsCount,
      this.itemsQty,
      this.grandTotal,
      this.subtotal,
      this.subtotalWithDiscount,
      this.items});

  CartDetail.fromJson(
    Map<String, dynamic> json,
  ) {
    quoteId = json['quote_id'];
    customerId = json['customer_id'];
    storeId = json['store_id'];
    isActive = json['is_active'];
    itemsCount = NumberParser.intFromDoubleString(json['items_count']);
    itemsQty = NumberParser.intFromDoubleString(json['items_qty']);
    grandTotal = NumberParser.intFromDoubleString(json['grand_total']);
    subtotal = NumberParser.intFromDoubleString(json['subtotal']);
    subtotalWithDiscount =
        NumberParser.intFromDoubleString(json['subtotal_with_discount']);
    items = json['items'] != null
        ? json['items'].map<CartItem>((e) => CartItem.fromJson(e)).toList()
        : null;
  }

  factory CartDetail.init() {
    return CartDetail(items: [], itemsCount: 0);
  }
}

class CartItem {
  String? productId;
  String? sku;
  String? name;
  int? price;
  int? qty;
  String? subTotal;
  Images? image;
  String? itemId;

  CartItem(
      {this.productId,
      this.sku,
      this.name,
      this.price,
      this.qty,
      this.subTotal,
      this.image,
      this.itemId});

  CartItem.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    itemId = json['item_id'];
    sku = json['sku'];
    name = json['name'];
    price = NumberParser.intFromDoubleString(json['price']);
    qty = NumberParser.intFromDoubleString(json['qty']);
    subTotal = json['sub_total'];
    image = json['image'] != null ? Images.fromJson(json['image']) : null;
  }
}

class Images {
  String? image;
  String? thumbnail;
  String? smallImage;

  Images({this.image, this.thumbnail, this.smallImage});

  Images.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    thumbnail = json['thumbnail'];
    smallImage = json['smallImage'];
  }
}
