import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rev_rider/main.dart';
import 'package:rev_rider/models/product_model.dart';
import 'package:rev_rider/widgets/cart_listview.dart';
import 'package:rxdart/rxdart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  Stream<List<Map<String, dynamic>>> cartItemsStream() {
    final cartRef = db
        .collection("Users")
        .doc(authService.currentUser?.uid)
        .collection('cart');

    return cartRef.snapshots().switchMap((cartSnapshot) {
      List<Stream<Map<String, dynamic>>> productStreams = [];

      for (var cartDoc in cartSnapshot.docs) {
        final productId = cartDoc.id;
        final quantity = cartDoc['quantity'];

        // For each product ID, listen to changes in product doc
        final productStream = db
            .collection('products')
            .doc(productId)
            .snapshots()
            .map((productSnap) {
          final productData = productSnap.data() ?? {};
          productData['quantity'] = quantity;
          return productData;
        });

        productStreams.add(productStream);
      }

      // If no items, return an empty stream
      if (productStreams.isEmpty) {
        return Stream.value([]);
      }

      // Combine all product streams into a single stream of list
      return Rx.combineLatestList(productStreams);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: cartItemsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Cart is empty"));
          }

          // final cartItems = snapshot.data!;

          return CartListview(snapshot: snapshot);
        },
      ),
    );
  }
}
