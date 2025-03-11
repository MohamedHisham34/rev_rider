// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

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
  ProductService productServices = ProductService();

  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // this is the area that can CategoryHorizontalListview exists
            Container(
              width: double.infinity,
              height: 60,
              child: Expanded(
                  child: ReusableFutureBuilder(
                future: categoriesReference.get(),
                content: (snapshot) {
                  var docs = snapshot.data.docs;
                  return CategoryHorizontalListview(
                      onTap: (Index) {
                        selectedCategory = docs[Index].id;
                        print(selectedCategory);
                        setState(() {});
                      },
                      snapshot: snapshot);
                },
              )),
            ),

            Expanded(
              child: ReusableFutureBuilder(
                future: productServices.getProductsByCategory(
                    selectedCategory: selectedCategory),
                content: (snapshot) {
                  var docs = snapshot.data.docs;
                  return ProductGridview(
                    snapshot: snapshot,
                    itemCount: docs.length,
                    onProductTap: (index) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetails(
                              selectedItemId: docs?[index]
                                  [ProductModel.firebaseField_productID]),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
