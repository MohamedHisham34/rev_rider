// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rev_rider/models/product_model.dart';
import 'package:rev_rider/services/product_service.dart';

class AdminProductInterface extends StatelessWidget {
  AdminProductInterface({super.key, required this.snapshot});

  AsyncSnapshot snapshot;
  String updatedItemName = '';
  String updatedItemDescription = '';
  double updatedItemPrice = 0;

  @override
  Widget build(BuildContext context) {
    ProductService _productService = ProductService();
    return ListView.builder(
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
        String itemName = snapshot.data?.docs[index]
                [ProductModel.firebaseField_itemName] ??
            "No Item Name Exists";

        String description = snapshot.data?.docs[index]
                [ProductModel.firebaseField_description] ??
            "No description";

        double price =
            snapshot.data?.docs[index][ProductModel.firebaseField_price];

        return Card(
          color: Colors.white24,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(itemName),
                Text(description),
                Text(price.toString()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      color: Colors.black,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text("Edit Product"),
                                  content: Column(children: [
                                    Text("Edit Item Name"),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextField(
                                      onChanged: (value) {
                                        updatedItemName = value;
                                      },
                                      decoration: InputDecoration(
                                          hintText: "Enter Item Name"),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("Edit Description"),
                                    TextField(
                                      onChanged: (value) {
                                        updatedItemDescription = value;
                                      },
                                      decoration: InputDecoration(
                                          hintText: "Enter Description"),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text("Edit Item Price"),
                                    TextField(
                                      onChanged: (value) {
                                        updatedItemPrice = double.parse(value);
                                      },
                                      decoration: InputDecoration(
                                          hintText: "Enter Price"),
                                    ),
                                  ]),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        _productService.updateProductByAdmin(
                                            snapshot: snapshot,
                                            index: index,
                                            updatedItemName: updatedItemName,
                                            updatedItemDescription:
                                                updatedItemDescription,
                                            updatedItemPrice: updatedItemPrice);
                                      },
                                      child: Text("Update"),
                                    )
                                  ],
                                ));
                      },
                      child: Text(
                        "Edit",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    MaterialButton(
                      color: Colors.red,
                      onPressed: () {
                        _productService.deleteProductByAdmin(snapshot, index);
                      },
                      child: Text("Delete"),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
    ;
  }
}
