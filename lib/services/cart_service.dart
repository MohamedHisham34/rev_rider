// ignore_for_file: unnecessary_string_interpolations, avoid_single_cascade_in_expression_statements

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rev_rider/main.dart';

CollectionReference cartReference = db
    .collection('Users')
    .doc("${authService.currentUser!.uid}")
    .collection('cart');

class CartService {
  removeProductFromCart(String selectedProductId) async {
    await cartReference.doc(selectedProductId).delete();
  }

  Stream<QuerySnapshot> cartItemsStream() {
    return db
        .collection('Users')
        .doc("${authService.currentUser?.uid}")
        .collection('cart')
        .snapshots();
  }

  Stream<QuerySnapshot> cartItemsByProductsId(
      {required Iterable<Object?>? productIds}) {
    return db
        .collection('products')
        .where("productID", whereIn: productIds)
        .snapshots();
  }

  double calculateTotalPrice({required List docs}) {
    double totalCartPrice = 0.00;
    for (var docs in docs) {
      double totalPrice = (docs.data() as Map<String, dynamic>)['price'] ?? 0.0;
      int quantity = (docs.data() as Map<String, dynamic>)['quantity'] ?? 1;
      totalCartPrice += totalPrice * quantity;
    }

    return totalCartPrice;
  }
}
