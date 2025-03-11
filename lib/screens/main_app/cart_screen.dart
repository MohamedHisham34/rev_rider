// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, prefer_const_literals_to_create_immutables, unnecessary_cast

import 'package:flutter/material.dart';
import 'package:rev_rider/models/cart_model.dart';
import 'package:rev_rider/screens/main_app/order_details_screen.dart';
import 'package:rev_rider/services/cart_service.dart';
import 'package:rev_rider/widgets/cart_listview.dart';
import 'package:rev_rider/widgets/reusable_stream_builder.dart';

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

        // Stream Builder for Cart items
        body: ReusableStreamBuilder(
          stream: cartService.cartItemsStream(),
          content: (snapshot) {
            var docs = snapshot.data?.docs;
            return Column(
              children: [
                Expanded(
                  //CART ITEMS INTERFACE
                  child: CartListview(
                    docs: docs,
                    itemCount: docs!.length,
                    removeButtonFunction: (index) {
                      var selectedProductId = snapshot.data?.docs[index]
                          [CartModel.firebaseField_productID];
                      cartService.removeProductFromCart(selectedProductId);
                    },
                  ),
                ),

                // TOTAL PRICE
                Text(
                    "${cartService.calculateTotalPrice(docs: docs).toString()}"),

                MaterialButton(
                  color: Colors.green,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetailsScreen(
                            totalCartPrice:
                                cartService.calculateTotalPrice(docs: docs),
                          ),
                        ));
                  },
                  child: Text("Order Now"),
                )
              ],
            );
          },
        ));
  }
}
