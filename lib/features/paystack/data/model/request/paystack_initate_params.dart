class PaystackInitiateParams {
  String? email;
  int? amount;
  String? reference;

  PaystackInitiateParams({this.email, this.amount,this.reference});

  Map toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['amount'] = amount;
    map['reference']=reference;
    return map;
  }
}
