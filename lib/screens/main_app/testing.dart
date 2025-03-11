// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
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

class Testing extends StatefulWidget {
  const Testing({super.key});

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  ProductService productServices = ProductService();

  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Column(
        children: [
          Text("No Change"),
          Text('model.name'),
          Expanded(
            child: FutureBuilder(
              future: db.collection("Test").get(),
              builder: (context, snapshot) {
                var docs = snapshot.data?.docs;
                return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Text(
                            docs?[index][Test.FirebaseField_Name] ?? "NO Data"),
                        Text(docs?[index][Test.FirebaseField_age]),
                        Text(docs?[index][Test.FirebaseField_gender]),
                      ],
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
