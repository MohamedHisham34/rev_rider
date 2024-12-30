// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rev_rider/main.dart';
import 'package:rev_rider/screens/product_details.dart';

class HomeScreen extends StatefulWidget {
  static final id = "HomeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void initState() {
    getData();
    super.initState();
  }

  var data = [];

  getData() async {
    try {
      QuerySnapshot querySnapshot = await db.collection("products").get();
      data.addAll(querySnapshot.docs);
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: SafeArea(
        child: GridView.builder(
          itemCount: data.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 20),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                String selectedItemId = data[index]['productID'];
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetails(
                        selectedItemId: selectedItemId,
                      ),
                    ));
              },
              child: Card(
                child: Column(
                  children: [
                    Text(data[index]['description'].toString()),
                    Text(data[index]['itemName'].toString()),
                    Text(data[index]['price'].toString()),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
