import 'package:rev_rider/models/product_model.dart';

class CartModel extends ProductModel {
  CartModel.addProductTCart({
    required super.itemName,
    required super.productID,
    required super.price,
    required super.stock,
    required super.quantity,
  }) : super.addProductTCart();

  Map<String, dynamic> cartInfo() {
    return {
      "productID": productID,
      "itemName": itemName,
      "price": price,
      "stock": stock,
      "quantity": quantity,
    };
  }
}
