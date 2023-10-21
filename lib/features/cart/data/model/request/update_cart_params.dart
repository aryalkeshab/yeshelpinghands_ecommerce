/*
{
    "sku": "SM-A336EZWGAFA",
    "qty": 50,
    "itemId": 37
}
 */

class UpdateCartParams {
  final int cartItemId;
  final int quantity;
  final String sku;

  const UpdateCartParams(
      {required this.cartItemId, required this.quantity, required this.sku});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['itemId'] = cartItemId;
    map['qty'] = quantity;
    map['sku'] = sku;
    return map;
  }
}
