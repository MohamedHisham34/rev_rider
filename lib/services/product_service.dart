import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rev_rider/main.dart';

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
}
