// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rev_rider/models/product_model.dart';
import 'package:rev_rider/screens/main_app/product_details.dart';
import 'package:rev_rider/services/category_service.dart';
import 'package:rev_rider/services/product_service.dart';
import 'package:rev_rider/widgets/category_horizontal_listview.dart';
import 'package:rev_rider/widgets/product_gridview.dart';
import 'package:rev_rider/widgets/reusable_future_builder.dart';

class HomeScreen extends StatefulWidget {
  static const id = "HomeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedCategoryIndex = 0;
  String? selectedCategory;
  ProductService _productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(
        children: [],
      ),
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
        title: Image.asset(
          scale: 10,
          "images/logo.png",
          fit: BoxFit.contain,
        ),
        centerTitle: true,
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: Icon(Icons.notifications_none, color: Colors.black),
                onPressed: () {},
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: BoxConstraints(minWidth: 14, minHeight: 14),
                  child: Center(
                    child: Text(
                      "1", // You can make this dynamic
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),

      // This THE START OF THE SCREEN

      body: ListView(
        children: [
          //ADS SECTION
          AdsContainer(),
          SizedBox(
            height: 30,
          ),

          // Products Section
          //
          //
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            padding: EdgeInsets.all(15),

            // Column With Category and Products
            child: Column(
              children: [
                Text("Category"),
                ReusableFutureBuilder(
                  future: categoriesReference.get(),
                  content: (snapshot) {
                    var docs = snapshot.data?.docs;

                    return SizedBox(
                      height: 50,
                      child: CategoryHorizontalListview(
                          selectedCategoryIndex: selectedCategoryIndex,
                          onTap: (Index) {
                            selectedCategoryIndex = Index;

                            selectedCategory = docs[Index].id;
                            print(selectedCategory);
                            setState(() {});
                          },
                          snapshot: snapshot),
                    );
                  },
                ),

                // Products View
                ReusableFutureBuilder(
                  future: _productService.getProductsByCategory(
                      selectedCategory: selectedCategory),
                  content: (snapshot) {
                    var docs = snapshot.data.docs;
                    return ProductGridview(
                      itemCount: docs.length,
                      onProductTap: (index) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetails(
                                  selectedItemId: docs?[index]
                                      [ProductModel.firebaseField_productID]),
                            ));
                      },
                      snapshot: snapshot,
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget AdsContainer() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(40),
      ),
    ),
    width: double.infinity,
    height: 150,
    child: Padding(
      padding: EdgeInsets.all(30),
      child: Container(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "NEW OFFER TEXT",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text("Discount 50% For The First Transaction ")
            ],
          ),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [
                  0,
                  1
                ],
                colors: [
                  const Color.fromARGB(255, 255, 255, 255),
                  Color.fromRGBO(29, 186, 144, 1)
                ])),
      ),
    ),
  );
}
