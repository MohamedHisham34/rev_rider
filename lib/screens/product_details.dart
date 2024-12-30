import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rev_rider/main.dart';

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
              return Text(
                  "Full Name: ${data['itemName']} description: ${data['description']} Price: ${data['price']}");
            }

            return Text("loading");
          },
        ),
      ),
    );
  }
}
