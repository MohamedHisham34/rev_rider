// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rev_rider/main.dart';
import 'package:rev_rider/models/product_model.dart';

class AdminAddProduct extends StatefulWidget {
  AdminAddProduct({super.key});

  @override
  State<AdminAddProduct> createState() => _AdminAddProductState();
}

class _AdminAddProductState extends State<AdminAddProduct> {
  String productId = Random().nextInt(999999999).toString();
  void initState() {
    checkRepeatedGenNumber();
    super.initState();
  }

  void checkRepeatedGenNumber() async {
    await db.collection("products").get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          if (productId == docSnapshot.id) {
            print("Generated Number Been Used");
            productId = Random().nextInt(999999999).toString();
            setState(() {});
          }
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  String? itemName;

  late bool isAvaliable = false;

  double? price;

  String? description;

  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdminProductScreen'),
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(hintText: "Enter item Name"),
            onChanged: (value) {
              itemName = value;
            },
          ),
          TextField(
            decoration: InputDecoration(hintText: "Enter Description"),
            onChanged: (value) {
              description = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(hintText: "Enter Price"),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              price = double.parse(value);
            },
          ),
          SizedBox(
            height: 10,
          ),
          Text("The Item Is Avaliable"),
          Checkbox(
            value: isAvaliable,
            onChanged: (value) {
              setState(() {
                isAvaliable = value!;
              });
            },
          ),
          MaterialButton(
            color: Colors.black,
            textColor: Colors.white,
            onPressed: () async {
              ProductModel productModel = ProductModel(
                  productID: productId,
                  itemName: itemName,
                  isAvaliable: isAvaliable,
                  price: price,
                  description: description,
                  imageUrl: null);

              db
                  .collection("products")
                  .doc("${productId}")
                  .set(productModel.productInfo());
            },
            child: Text("ADD PRODUCT"),
          ),
        ],
      ),
    );
  }
}
