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

  Stream<QuerySnapshot> cartItemsByProductsIds(
      {required Iterable<Object?>? productIds}) {
    return db
        .collection('products')
        .where("productID", whereIn: productIds)
        .snapshots();
  }

  // double calculateTotalPrice({required List productDocs , required List cartDocs}) {
  //   double totalCartPrice = 0.00;
  //   for (var docs in cartDocs , var docs in productDocs) {
  //     double totalPrice = (docs.data() as Map<String, dynamic>)['price'] ?? 0.0;
  //     int quantity = (docs.data() as Map<String, dynamic>)['quantity'] ?? 1;
  //     totalCartPrice += totalPrice * quantity;
  //   }

  //   return totalCartPrice;
  // }

  double cal({required List productsDocs, required List cartDocs}) {
    int len = cartDocs.length < productsDocs.length
        ? cartDocs.length
        : productsDocs.length;
    double totalCartPrice = 0.00;
    for (int i = 0; i < len; i++) {
      final cartData = cartDocs[i].data() as Map<String, dynamic>;
      final productData = productsDocs[i].data() as Map<String, dynamic>;

      double price = productData['price'] ?? 0.0;
      int quantity = cartData['quantity'] ?? 1;

      totalCartPrice += price * quantity;
    }
    return totalCartPrice;
  }

  getData({required List cartProductsIds}) async {
    await db
        .collection("Users")
        .doc(authService.currentUser?.uid)
        .collection('cart')
        .get()
        .then(
      (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          cartProductsIds.add(docSnapshot.id);
          print(cartProductsIds);
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }
}
