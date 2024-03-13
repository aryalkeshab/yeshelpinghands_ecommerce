class UpdateCartParams {
  final String cartItemId;
  final int quantity;

  const UpdateCartParams({
    required this.cartItemId,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['product_slug'] = cartItemId;
    map['qty'] = quantity;
    return map;
  }
}
