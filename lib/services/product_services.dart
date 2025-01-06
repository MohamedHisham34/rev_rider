import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rev_rider/main.dart';

class ProductServices {
  // get Product by choosing category
  //selectedCategory is equal the selectedCategory in Home Page

  Future<QuerySnapshot<Object?>>? getProductsByCategory(
      {required String? selectedCategory}) async {
    return await db
        .collection('products')
        .where("productCategory", isEqualTo: selectedCategory)
        .get();
  }
}
