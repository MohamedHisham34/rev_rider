// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rev_rider/models/product_model.dart';
import 'package:rev_rider/services/product_service.dart';

class AdminAddProductInterface extends StatelessWidget {
  AdminAddProductInterface({
    super.key,
    required this.snapshot,
  });
  final AsyncSnapshot snapshot;

  String productId = Random().nextInt(999999999).toString();

  var selectedCategory;

  String? itemName;

  double? price;

  String? description;

  String? imageUrl;

  int? stock;

  @override
  Widget build(BuildContext context) {
    return Column(
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
            try {
              price = double.parse(value);
            } catch (e) {
              print(e);
            }
          },
        ),
        TextFormField(
          decoration: InputDecoration(hintText: "Enter Number Of Items"),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            try {
              stock = int.parse(value);
            } catch (e) {
              print(e);
            }
          },
        ),
        SizedBox(
          height: 10,
        ),
        Text('Enter Product Category'),
        DropdownMenu(
          dropdownMenuEntries: List.generate(
            snapshot.data!.docs.length ?? 3,
            (index) {
              return DropdownMenuEntry(
                value: snapshot.data?.docs[index].id,
                label: snapshot.data?.docs[index]['name'],
              );
            },
          ),
          onSelected: (value) {
            selectedCategory = value;
            print(selectedCategory);
          },
        ),
        MaterialButton(
          color: Colors.black,
          textColor: Colors.white,
          onPressed: () async {
            ProductModel productModel = ProductModel.addProductToApp(
                productID: productId,
                itemName: itemName,
                price: price,
                description: description,
                imageUrl: null,
                stock: stock,
                productCategory: selectedCategory);

            productReference.doc(productId).set(productModel.productInfo());
          },
          child: Text("ADD PRODUCT"),
        ),
      ],
    );
  }
}
