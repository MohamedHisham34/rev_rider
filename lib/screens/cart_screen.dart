// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rev_rider/main.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Stream<QuerySnapshot> cartItemsStream = db
      .collection('Users')
      .doc("${authService.currentUser!.uid}")
      .collection('cart')
      .snapshots();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Page'),
      ),
      body: StreamBuilder(
        stream: cartItemsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error Getting documents");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  children: [
                    Text(snapshot.data?.docs[index]['itemName']),
                    Text("${snapshot.data?.docs[index]['price'].toString()}"),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
