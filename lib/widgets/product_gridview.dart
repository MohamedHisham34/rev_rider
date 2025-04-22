// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rev_rider/models/product_model.dart';

class ProductGridview extends StatelessWidget {
  const ProductGridview(
      {super.key,
      required this.itemCount,
      required this.onProductTap,
      required this.snapshot});

  final int? itemCount;
  final Function onProductTap;
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 20),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        String imageUrl = snapshot.data.docs[index]
                [ProductModel.firebaseField_imageUrl] ??
            "https://i.postimg.cc/nctPmPQm/logo.png";

        String itemName = snapshot.data.docs[index]
                .data()
                .containsKey(ProductModel.firebaseField_itemName)
            ? snapshot.data.docs[index][ProductModel.firebaseField_itemName] ??
                "Item Got No Name"
            : "Database Error";

        double price =
            snapshot.data.docs[index][ProductModel.firebaseField_price] ?? 0;
        return GestureDetector(
          onTap: () {
            onProductTap(index);
          },
          child: Card(
            child: Column(children: [
              Image(
                height: 100,
                image: NetworkImage("$imageUrl"),
              ),
              Text("$itemName"),
              Text("$price"),
            ]),
          ),
        );
      },
    );
    ;
  }
}
