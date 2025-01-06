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
  List<String> listedCatogoryValue = [];
  List listedCatogoryLabel = [];
  Map Listed = {};
  var selectedCatogory;
  var selectedKCategory = 'category1';
  void initState() {
    getData();
    getNewData();
    super.initState();
  }

  getData() async {
    await db.collection('categories').get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          listedCatogoryValue.add(docSnapshot.id);
          listedCatogoryLabel.add(docSnapshot.data()['name']);
          Listed.addAll({"${docSnapshot.id}": "${docSnapshot.data()['name']}"});
          print(Listed.values);
          setState(() {});
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  getNewData() async {
    await db.collection("products").get().then(
      (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          print(
              '${docSnapshot.id} => ${docSnapshot.data()['productCategory']}');
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
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
              return Text(snapshot.data?.docs[index]['itemName'] ??
                  'Not Contain Category');
            },
          );
        },
      ),
    );
  }
}
