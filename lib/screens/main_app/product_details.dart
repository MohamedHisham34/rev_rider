// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rev_rider/main.dart';
import 'package:rev_rider/models/cart_model.dart';
import 'package:rev_rider/services/product_service.dart';
import 'package:rev_rider/widgets/quantity_selector.dart';

class ProductDetails extends StatefulWidget {
  final String selectedItemId;
  const ProductDetails({super.key, required this.selectedItemId});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
// Started quantity
  int quantity = 1;

// productService
  ProductService productService = ProductService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          //Future Builder For Product Details
          future: productService.getSingleProductById(
              selectedItemId: widget.selectedItemId),

          //
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return Text("Document does not exist");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;

              //////////////////////////////////////
              /////////////////////////////////////

              return Scaffold(
                appBar: AppBar(
                  title: const Text('Product Details'),
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("items Name: ${data['itemName']} "
                        " description: ${data['description']} "
                        " Item Price: ${data['price']}"),

                    // Quantity Selector Widget to Adjust Quantity
                    QuantitySelector(
                      quantity: quantity.toString(),
                      onPlusTap: () {
                        setState(() {
                          quantity++;
                        });
                      },
                      onMinusTap: () {
                        setState(() {
                          quantity--;
                        });
                      },
                    ),

                    MaterialButton(
                      onPressed: () async {
                        double price = double.parse("${data["price"]}");
                        int stock = int.parse("${data['stock']}");

                        CartModel cartModel = CartModel.addProductTCart(
                            quantity: quantity,
                            itemName: "${data['itemName']}",
                            productID: "${widget.selectedItemId}",
                            price: price,
                            stock: stock);

                        await db
                            .collection("Users")
                            .doc(authService.currentUser!.uid)
                            .collection('cart')
                            .doc("${widget.selectedItemId}")
                            .set(cartModel.cartInfo());
                      },
                      child: Text("Add To Cart"),
                    )
                  ],
                ),
              );
            }

            return Text("loading");
          },
        ),
      ),
    );
  }
}
