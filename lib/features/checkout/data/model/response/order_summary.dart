import 'package:yeshelpinghand/core/utils/number_parser.dart';
import 'package:yeshelpinghand/features/home/data/models/response/products_model.dart';

class OrderSummary {
  String? quoteId;
  int? itemsCount;
  int? itemsQty;
  int? grandTotal;
  int? subtotal;
  String? shippingMethod;
  String? shippingDescription;
  int? shippingAmount;
  int? zenithubMemberpointPaymentAmount;
  String? paymentMethod;

  List<Items>? items;

  OrderSummary(
      {this.quoteId,
      this.itemsCount,
      this.paymentMethod,
      this.itemsQty,
      this.grandTotal,
      this.subtotal,
      this.zenithubMemberpointPaymentAmount,
      this.shippingMethod,
      this.shippingDescription,
      this.shippingAmount,
      this.items});

  OrderSummary.fromJson(Map<String, dynamic> json) {
    quoteId = json['quote_id'];
    itemsCount = NumberParser.intFromDoubleString(json['items_count']);
    itemsQty = NumberParser.intFromDoubleString(json['items_qty']);
    grandTotal = NumberParser.intFromDoubleString(json['grand_total']);
    subtotal = NumberParser.intFromDoubleString(json['subtotal']);
    paymentMethod = json['payment_method'];
    shippingMethod = json['shipping_method'];
    shippingDescription = json['shipping_description'];
    shippingAmount = NumberParser.intFromDoubleString(json['shipping_amount']);
    zenithubMemberpointPaymentAmount = json["zenithub_memberpointpayment_amount"];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }
}

class Items {
  String? itemId;
  String? productId;
  String? sku;
  String? name;
  int? qty;
  int? price;
  ProductImage? image;

  Items({this.itemId, this.productId, this.sku, this.name, this.qty, this.price, this.image});

  Items.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    productId = json['product_id'];
    sku = json['sku'];
    name = json['name'];
    qty = NumberParser.intFromDoubleString(json['qty']);
    price = NumberParser.intFromDoubleString(json['price']);
    image = json['image'] != null ? ProductImage.fromJson(json['image']) : null;
  }
}
