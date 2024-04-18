import 'package:mham/models/cart_model.dart';

class OneProductModel {
  Product? product;

  OneProductModel.fromJson(Map<String, dynamic> json) {
    product =
    json['product'] != null ?  Product.fromJson(json['product']) : null;
  }

}
