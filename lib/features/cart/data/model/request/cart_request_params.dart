class CartParams {
  String? sku;
  int? qty;

  CartParams({
    this.sku,
    this.qty,
  });

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['sku'] = this.sku;
    map['qty'] = this.qty;
    return map;
  }
}
