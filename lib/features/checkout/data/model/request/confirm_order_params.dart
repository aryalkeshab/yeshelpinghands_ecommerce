import 'package:yeshelpinghand/features/cart/data/model/response/cart_details.dart';
import 'package:yeshelpinghand/features/checkout/data/model/response/payment_method.dart';

import '../../../../address/data/model/response/address.dart';

class ConfirmOrderParams {
  CartDetail? cartDetail;
  Address? shippingAddress;
  Address? billingAddress;
  String? shippingMethod;
  PaymentMethod? paymentMethod;
  int? grandTotal;

  ConfirmOrderParams({
    this.cartDetail,
    this.shippingAddress,
    this.billingAddress,
    this.shippingMethod,
    this.paymentMethod,
  });

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};

    return map;
  }

  Map<String, dynamic> toShippingInfoJson() {
    var map = <String, dynamic>{};

    map['shipping_method'] = shippingMethod;
    map['shipping_address_id'] = shippingAddress?.id;
    map['billing_address_id'] = billingAddress?.id;
    return map;
  }
}
