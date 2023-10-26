class CartParams {
  String? slug;
  int? qty;

  CartParams({
    this.slug,
    this.qty,
  });

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['slug'] = this.slug;
    map['qty'] = this.qty;
    return map;
  }
}
