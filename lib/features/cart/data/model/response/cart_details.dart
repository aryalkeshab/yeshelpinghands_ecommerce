class CartResponse {
  List<Carts>? carts;
  Total? total;

  CartResponse({this.carts, this.total});

  CartResponse.fromJson(Map<String, dynamic> json) {
    if (json['carts'] != null) {
      carts = <Carts>[];
      json['carts'].forEach((v) {
        carts!.add(new Carts.fromJson(v));
      });
    }
    total = json['total'] != null ? new Total.fromJson(json['total']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.carts != null) {
      data['carts'] = this.carts!.map((v) => v.toJson()).toList();
    }
    if (this.total != null) {
      data['total'] = this.total!.toJson();
    }
    return data;
  }
}

class Carts {
  String? name;
  String? slug;
  String? image;
  String? price;
  String? offerPrice;
  int? id;
  // int? productId;
  int? qty;
  String? actualPrice;
  String? priceUsed;
  String? totalPrice;
  // int? variantId;
  // String? variantValue;
  // int? userId;
  // String? createdAt;
  // String? updatedAt;

  Carts({
    this.name,
    this.slug,
    this.image,
    this.price,
    this.offerPrice,
    this.id,
    // this.productId,
    this.qty,
    this.actualPrice,
    this.priceUsed,
    this.totalPrice,
    // this.variantId,
    // this.variantValue,
    // this.userId,
    // this.createdAt,
    // this.updatedAt,
  });

  Carts.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    price = json['price'];
    offerPrice = json['offer_price'];
    id = json['id'];
    // productId = json['product_id'];
    qty = json['qty'];
    actualPrice = json['actual_price'];
    priceUsed = json['price_used'];
    totalPrice = json['total_price'];
    // variantId = json['variant_id'];
    // variantValue = json['variant_value'];
    // userId = json['user_id'];
    // createdAt = json['created_at'];
    // updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['image'] = this.image;
    data['price'] = this.price;
    data['offer_price'] = this.offerPrice;
    data['id'] = this.id;
    // data['product_id'] = this.productId;
    data['qty'] = this.qty;
    data['actual_price'] = this.actualPrice;
    data['price_used'] = this.priceUsed;
    data['total_price'] = this.totalPrice;
    // data['variant_id'] = this.variantId;
    // data['variant_value'] = this.variantValue;
    // data['user_id'] = this.userId;
    // data['created_at'] = this.createdAt;
    // data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Total {
  double? total;
  double? discount;
  double? subTotal;
  double? shipping;
  double? walletDiscount;
  double? grandTotal;

  Total(
      {this.total,
      this.discount,
      this.subTotal,
      this.shipping,
      this.walletDiscount,
      this.grandTotal});

  Total.fromJson(Map<String, dynamic> json) {
    total = double.parse(json['total'].toString());
    discount = double.parse(json['discount'].toString());
    subTotal = double.parse(json['sub_total'].toString());
    shipping = double.parse(json['shipping'].toString());
    walletDiscount = double.parse("${json['wallet_discount'] ?? 0}".toString());
    grandTotal = double.parse(json['grand_total'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['discount'] = this.discount;
    data['sub_total'] = this.subTotal;
    data['shipping'] = this.shipping;
    data['wallet_discount'] = this.walletDiscount;
    data['grand_total'] = this.grandTotal;
    return data;
  }
}
