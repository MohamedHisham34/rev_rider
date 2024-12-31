// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rev_rider/main.dart';
import 'package:rev_rider/models/cart_model.dart';

class ProductDetails extends StatefulWidget {
  final String selectedItemId;
  const ProductDetails({super.key, required this.selectedItemId});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: db.collection("products").doc(widget.selectedItemId).get(),
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
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Title'),
                ),
                body: Column(
                  children: [
                    Text(
                        "Full Name: ${data['itemName']} description: ${data['description']} Price: ${data['price']}"),
                    MaterialButton(
                      onPressed: () async {
                        double price = double.parse("${data["price"]}");

                        CartModel cartModel = CartModel(
                            productID: "${widget.selectedItemId}",
                            itemName: "${data['itemName']}",
                            isAvaliable: true,
                            price: price,
                            description: "${data['description']}",
                            imageUrl: null);

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
