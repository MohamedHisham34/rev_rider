// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rev_rider/main.dart';
import 'package:rev_rider/models/cart_model.dart';
import 'package:rev_rider/models/product_model.dart';
import 'package:rev_rider/services/cart_service.dart';
import 'package:rev_rider/services/product_service.dart';
import 'package:rev_rider/widgets/reusable_future_builder.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartService _cartService = CartService();
  Stream<QuerySnapshot> cartItem = cartReference.snapshots();
  Stream<QuerySnapshot> productItems = productReference.snapshots();

  List<String> cartProductsIds = [];

  @override
  Widget build(BuildContext context) {
    return ReusableFutureBuilder(
      future: _cartService.getCartItemsIds(cartProductsIds: cartProductsIds),
      content: (snapshot) {
        return StreamBuilder(
          stream: cartItem,
          builder: (context, cartSnapshot) {
            var cartDocs = cartSnapshot.data?.docs ?? [];
            return StreamBuilder(
              stream: _cartService.cartItemsByProductsIds(
                  productIds: cartProductsIds),
              builder: (context, productSnapshot) {
                var productsDocs = productSnapshot.data?.docs ?? [];
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cartSnapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          String itemName = productSnapshot.data?.docs[index]
                                  [ProductModel.firebaseField_itemName] ??
                              "Couldn't Fetch Item Name";

                          int quantity = cartSnapshot.data?.docs[index]
                                  [CartModel.firebaseField_quantity] ??
                              1;

                          double price = productSnapshot
                                  .data
                                  ?.docs[index]
                                      [ProductModel.firebaseField_price]
                                  ?.toDouble() ??
                              0.0;

                          double totalPrice = quantity * price;
                          return Column(
                            children: [
                              Text(itemName),
                              Text("$quantity"),
                              Text("$totalPrice"),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          );
                        },
                      ),
                    ),
                    Text(
                        "${_cartService.calculateTotalPrice(productsDocs: productsDocs, cartDocs: cartDocs)}"),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
