// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:rev_rider/services/product_service.dart';
import 'package:rev_rider/widgets/admin_product_interface.dart';
import 'package:rev_rider/widgets/reusable_stream_builder.dart';

class AdminProductList extends StatefulWidget {
  const AdminProductList({super.key});

  @override
  State<AdminProductList> createState() => _AdminProductListState();
}

class _AdminProductListState extends State<AdminProductList> {
  ProductService productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return ReusableStreamBuilder(
      stream: productService.productStream,
      content: (snapshot) {
        return AdminProductInterface(snapshot: snapshot);
      },
    );
  }
}
