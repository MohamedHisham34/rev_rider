// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rev_rider/main.dart';
import 'package:rev_rider/services/cart_service.dart';
import 'package:rev_rider/widgets/cart_listview.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartService cartService = CartService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Page'),
      ),
      body: StreamBuilder(
        stream: cartService.getCartItems(),
        builder: (context, snapshot) {
          var docs = snapshot.data?.docs;
          if (snapshot.hasError) {
            return Text("Error Getting documents");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            children: [
              Expanded(
                child: CartListview(
                  docs: docs,
                  itemCount: docs!.length,
                  removeButtonFunction: (index) {
                    var selectedProductId =
                        snapshot.data?.docs[index]['productID'];
                    cartService.removeProductFromCart(selectedProductId);
                  },
                ),
              ),
              Text("Total Price"),
            ],
          );
        },
      ),
    );
  }
}
