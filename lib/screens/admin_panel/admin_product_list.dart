// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:rev_rider/main.dart';
import 'package:rev_rider/services/product_service.dart';

class AdminProductList extends StatefulWidget {
  const AdminProductList({super.key});

  @override
  State<AdminProductList> createState() => _AdminProductListState();
}

class _AdminProductListState extends State<AdminProductList> {
  String updatedItemName = '';
  String updatedItemDescription = '';
  double updatedItemPrice = 0;

  ProductService productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: productService.productStream,
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
            String itemName =
                snapshot.data?.docs[index]["itemName"] ?? "No Item Name Exists";

            String description =
                snapshot.data?.docs[index]["description"] ?? "No description";

            double price = snapshot.data?.docs[index]["price"];

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
                                            updatedItemPrice =
                                                double.parse(value);
                                          },
                                          decoration: InputDecoration(
                                              hintText: "Enter Price"),
                                        ),
                                      ]),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            print(updatedItemName);
                                            print(updatedItemDescription);
                                            print(updatedItemPrice);

                                            db
                                                .collection('products')
                                                .doc(snapshot.data?.docs[index]
                                                    ['productID'])
                                                .update({
                                              "itemName": updatedItemName
                                            });
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
                            var selectedProductId =
                                snapshot.data?.docs[index]['productID'];
                            db
                                .collection('products')
                                .doc(selectedProductId)
                                .delete();
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
      },
    );
  }
}
