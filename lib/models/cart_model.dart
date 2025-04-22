// ignore_for_file: constant_identifier_names

import 'package:rev_rider/main.dart';
import 'package:rev_rider/models/product_model.dart';

class CartModel extends ProductModel {
  static const String firebaseField_productID = 'productID';
  static const String firebaseField_quantity = 'quantity';

  CartModel.addProductTCart({
    required super.productID,
    required super.quantity,
  }) : super.addProductTCart();

  Map<String, dynamic> cartInfo() {
    return {
      firebaseField_productID: productID,
      firebaseField_quantity: quantity,
    };
  }
}
