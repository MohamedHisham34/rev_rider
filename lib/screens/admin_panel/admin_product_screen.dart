// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rev_rider/main.dart';
import 'package:rev_rider/models/product_model.dart';

class AdminProductScreen extends StatefulWidget {
  AdminProductScreen({super.key});

  @override
  State<AdminProductScreen> createState() => _AdminProductScreenState();
}

class _AdminProductScreenState extends State<AdminProductScreen> {
  String? productID;

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
            decoration: InputDecoration(hintText: "Enter ID"),
            onChanged: (value) {
              productID = value;
            },
          ),
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
                  productID: productID,
                  itemName: itemName,
                  isAvaliable: isAvaliable,
                  price: price,
                  description: description,
                  imageUrl: null);

              db.collection("products").add(productModel.productInfo());
            },
            child: Text("ADD PRODUCT"),
          ),
        ],
      ),
    );
  }
}
