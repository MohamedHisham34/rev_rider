// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rev_rider/main.dart';

class TestFunctions extends StatefulWidget {
  const TestFunctions({super.key});

  @override
  State<TestFunctions> createState() => _TestFunctionsState();
}

class _TestFunctionsState extends State<TestFunctions> {
  List<String> listedCategoryValue = [];
  List<double> listedCategoryPrice = [];
  Map Listed = {};
  var selectedCategory;
  var selectedKCategory = 'category1';
  double? totalPrice;
  void initState() {
    getData();
    super.initState();
  }

  Future<List> getData() async {
    await db.collection('products').get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          listedCategoryValue.add(docSnapshot.id);
          listedCategoryPrice.add(docSnapshot.data()['price']);
          print(listedCategoryPrice[1]);
          setState(() {});
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    return listedCategoryPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: db
            .collection('products')
            .where("productCategory", isEqualTo: selectedKCategory)
            .get(),
        builder: (context, snapshot) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 20),
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              return Text('t');
            },
          );
        },
      ),
    );
  }
}
