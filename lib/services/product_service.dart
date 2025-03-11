import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rev_rider/main.dart';
import 'package:rev_rider/models/product_model.dart';

CollectionReference<Map<String, dynamic>> productReference =
    db.collection('products');

class ProductService {
  Stream<QuerySnapshot> productStream = db.collection('products').snapshots();

  // get Product by choosing category
  //selectedCategory is equal the selectedCategory in Home Page

  Future<QuerySnapshot<Object?>>? getProductsByCategory(
      {required String? selectedCategory}) async {
    return await db
        .collection('products')
        .where("productCategory", isEqualTo: selectedCategory)
        .get();
  }

  Future<DocumentSnapshot<Object?>>? getSingleProductById(
      {required String selectedItemId}) async {
    return await db.collection("products").doc(selectedItemId).get();
  }

  void updateProductByAdmin(
      {required AsyncSnapshot snapshot,
      required int index,
      required String updatedItemName,
      required String updatedItemDescription,
      required double updatedItemPrice}) {
    productReference.doc(snapshot.data?.docs[index]['productID']).update({
      "itemName": updatedItemName,
      "description": updatedItemDescription,
      "price": updatedItemPrice
    });
  }

  void deleteProductByAdmin(AsyncSnapshot snapshot, int index) {
    var selectedProductId = snapshot.data?.docs[index]['productID'];
    productReference.doc(selectedProductId).delete();
  }
}
