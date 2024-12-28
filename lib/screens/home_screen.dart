// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rev_rider/main.dart';

class HomeScreen extends StatefulWidget {
  static final id = "HomeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var file;
  final ImagePicker picker = ImagePicker();

  getimage() async {
    final XFile? imagex = await picker.pickImage(source: ImageSource.camera);
    file = File(imagex!.path);
    setState(() {});
  }

  void initState() {
    // getData();
    super.initState();
  }

  var data = [];

  // getData() async {
  //   QuerySnapshot querySnapshot = await db.collection("mohamed").get();
  //   data.addAll(querySnapshot.docs);
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            getimage();
          },
          child: Text(
            "Click",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Home Page'),
    //   ),
    //   body: SafeArea(
    //     child: GridView.builder(
    //       itemCount: data.length,
    //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //           crossAxisCount: 2, mainAxisSpacing: 20),
    //       itemBuilder: (context, index) {
    //         return Text("${data[index]["name"]}");
    //       },
    //     ),
    //   ),
    // );
  }
}
