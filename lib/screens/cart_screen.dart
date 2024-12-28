// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    getData();
    addData();
    super.initState();
  }

  var data = [];
  FirebaseFirestore db = FirebaseFirestore.instance;

  getData() async {
    QuerySnapshot querySnapshot = await db.collection("mohamed").get();
    setState(() {});
    data.addAll(querySnapshot.docs);
  }

  addData() async {
    await db.collection("mohamed").add({"name": "ahmed", "age": "32"});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Page'),
      ),
      body: SafeArea(
        child: GridView.builder(
          itemCount: data.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 20),
          itemBuilder: (context, index) {
            return Text("${data[index]["name"]}");
          },
        ),
      ),
    );
  }
}
