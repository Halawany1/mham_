class ReturnOrderModel {
  int? cartProductId;
  String? reason;
  int? quantity;


  ReturnOrderModel({required this.cartProductId,required this.reason,required this.quantity});

  ReturnOrderModel.fromJson(Map<String, dynamic> json) {
    cartProductId = json['cartProduct_id'];
    reason = json['reason'];
    quantity = json['quantity'];
  }

}