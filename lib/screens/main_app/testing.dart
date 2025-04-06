// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rev_rider/main.dart';
import 'package:rev_rider/models/product_model.dart';
import 'package:rev_rider/models/test.dart';
import 'package:rev_rider/screens/main_app/product_details.dart';
import 'package:rev_rider/services/category_service.dart';
import 'package:rev_rider/services/product_service.dart';
import 'package:rev_rider/widgets/category_horizontal_listview.dart';
import 'package:rev_rider/widgets/product_gridview.dart';
import 'package:rev_rider/widgets/reusable_future_builder.dart';
import 'package:rev_rider/widgets/reusable_stream_builder.dart';

class Testing extends StatefulWidget {
  const Testing({super.key});

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  List<String> test = [];

  Map allCartData = {};

  ProductService productServices = ProductService();

  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: Container(
        child: TextButton(
            onPressed: () {
              allCartData.addAll({"Test": "test"});
              allCartData.addAll({"Test": "Mohamed"});
              print(allCartData);
            },
            child: Text("data")),
      ),
    );
  }
}
