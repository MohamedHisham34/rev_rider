// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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
  getData() async {
    await db.collection('categories').get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          listedCategoryValue.add(docSnapshot.id);
          listedCategoryLabel.add(docSnapshot.data()['name']);
          setState(() {});
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  String productId = Random().nextInt(999999999).toString();
  void initState() {
    checkRepeatedGenNumber();
    getData();
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

  List<String> listedCategoryValue = [];
  List listedCategoryLabel = [];
  var selectedCategory;

  String? itemName;

  late bool isAvaliable = true;

  double? price;

  String? description;

  String? imageUrl;

  int? stock;

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
              listedCategoryValue.length,
              (index) {
                return DropdownMenuEntry(
                  value: listedCategoryValue[index],
                  label: listedCategoryLabel[index],
                );
              },
            ),
            onSelected: (value) {
              selectedCategory = value;
              print(selectedCategory);
            },
          ),

          // Text("The Item Is Avaliable"),
          // Checkbox(
          //   value: isAvaliable,
          //   onChanged: (value) {
          //     setState(() {
          //       isAvaliable = value!;
          //     });
          //   },
          // ),
          MaterialButton(
            color: Colors.black,
            textColor: Colors.white,
            onPressed: () async {
              ProductModel productModel = ProductModel(
                  productID: productId,
                  itemName: itemName,
                  price: price,
                  description: description,
                  stock: stock,
                  productCategory: selectedCategory,
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
