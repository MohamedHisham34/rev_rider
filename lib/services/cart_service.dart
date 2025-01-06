import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rev_rider/main.dart';

class CartService {
  removeProductFromCart(String selectedProductId) async {
    await db
        .collection('Users')
        .doc(authService.currentUser?.uid)
        .collection('cart')
        .doc(selectedProductId)
        .delete();
  }

  Stream<QuerySnapshot> getCartItems() {
    return db
        .collection('Users')
        .doc("${authService.currentUser!.uid}")
        .collection('cart')
        .snapshots();
  }
}
