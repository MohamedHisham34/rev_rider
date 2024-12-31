import 'package:rev_rider/models/product_model.dart';

class CartModel extends ProductModel {
  CartModel(
      {required super.productID,
      required super.itemName,
      required super.isAvaliable,
      required super.price,
      required super.description,
      required super.imageUrl});

  Map<String, dynamic> cartInfo() {
    return {
      "productID": productID,
      "itemName": itemName,
      "price": price,
      "imageUrl": imageUrl,
    };
  }
}
