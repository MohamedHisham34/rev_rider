// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rev_rider/main.dart';

class HomeScreen extends StatefulWidget {
  static final id = "HomeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void initState() {
    getData();
    addData();
    super.initState();
  }

  var data = [];

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
        title: const Text('Home Page'),
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
