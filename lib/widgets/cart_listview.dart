import 'package:flutter/material.dart';
import 'package:rev_rider/models/cart_model.dart';
import 'package:rev_rider/models/product_model.dart';

class CartListview extends StatelessWidget {
  const CartListview({super.key, required this.snapshot});

  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: snapshot.data?.length,
      itemBuilder: (context, index) {
        final cartItems = snapshot.data!;

        final item = cartItems[index];
        return ListTile(
          title: Text(item[ProductModel.firebaseField_itemName] ?? "No Name"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Quantity: ${item[CartModel.firebaseField_quantity]}"),
              Text("Price: ₹${item[ProductModel.firebaseField_price]}"),
            ],
          ),
        );
      },
    );
    ;
  }
}
