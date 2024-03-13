class Order {
  int? id;
  String? uniqueId;
  String? firstName;
  String? lastName;
  int? customerId;
  String? contactPerson;
  String? email;
  String? phone;
  String? priceBeforeDiscount;
  String? discountAmount;
  String? total;
  int? quantity;
  Null note;
  String? orderStatus;
  Null addressId;
  String? orderFrom;
  String? createdAt;
  String? updatedAt;
  Null deletedAt;
  String? shippingCharge;

  Order(
      {this.id,
      this.uniqueId,
      this.firstName,
      this.lastName,
      this.customerId,
      this.contactPerson,
      this.email,
      this.phone,
      this.priceBeforeDiscount,
      this.discountAmount,
      this.total,
      this.quantity,
      this.note,
      this.orderStatus,
      this.addressId,
      this.orderFrom,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.shippingCharge});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uniqueId = json['unique_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    customerId = json['customer_id'];
    contactPerson = json['contact_person'];
    email = json['email'];
    phone = json['phone'];
    priceBeforeDiscount = json['price_before_discount'];
    discountAmount = json['discount_amount'];
    total = json['total'];
    quantity = json['quantity'];
    note = json['note'];
    orderStatus = json['order_status'];
    addressId = json['address_id'];
    orderFrom = json['order_from'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    shippingCharge = json['shipping_charge'];
  }
}
