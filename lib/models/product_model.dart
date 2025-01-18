import 'package:meta/meta.dart';

class ProductModel {
  String? productID;
  String? itemName;
  double? price;
  String? description;
  String? imageUrl;
  int? stock;
  String? productCategory;
  int? quantity;

  ProductModel.addProductToApp({
    required this.productID,
    required this.itemName,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.stock,
    required this.productCategory,
  });

  ProductModel.addProductTCart({
    required this.itemName,
    required this.productID,
    required this.price,
    required this.stock,
    required this.quantity,
  });

  Map<String, dynamic> productInfo() {
    return {
      "productID": productID,
      "itemName": itemName,
      "price": price,
      "description": description,
      "imageUrl": imageUrl,
      "stock": stock,
      "productCategory": productCategory,
    };
  }
}
