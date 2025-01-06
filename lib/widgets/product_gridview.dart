// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductGridview extends StatefulWidget {
  const ProductGridview(
      {super.key,
      required this.itemCount,
      required this.productName,
      required this.productDescription,
      required this.productList,
      required this.onProductTap});

  final int? itemCount;
  final List<QueryDocumentSnapshot<Object?>>? productList;
  final String productName;
  final String productDescription;
  final Function onProductTap;

  @override
  State<ProductGridview> createState() => _ProductGridviewState();
}

class _ProductGridviewState extends State<ProductGridview> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 20),
      itemCount: widget.itemCount,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            widget.onProductTap(index);
          },
          child: Card(
            child: Column(children: [
              Text("${widget.productList?[index]['${widget.productName}']}"),
              Text(
                  "${widget.productList?[index]['${widget.productDescription}']}"),
            ]),
          ),
        );
      },
    );
    ;
  }
}
