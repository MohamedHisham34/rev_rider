// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:rev_rider/main.dart';

class ProductModel {
  static const String firebaseField_productID = 'productID';
  static const String firebaseField_itemName = 'itemName';
  static const String firebaseField_price = 'price';
  static const String firebaseField_description = 'description';
  static const String firebaseField_imageUrl = 'imageUrl';
  static const String firebaseField_stock = 'stock';
  static const String firebaseField_productCategory = 'productCategory';

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
      firebaseField_productID: productID,
      firebaseField_itemName: itemName,
      firebaseField_price: price,
      firebaseField_description: description,
      firebaseField_imageUrl: imageUrl,
      firebaseField_stock: stock,
      firebaseField_productCategory: productCategory,
    };
  }
}
