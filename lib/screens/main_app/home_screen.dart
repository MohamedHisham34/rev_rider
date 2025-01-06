// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rev_rider/screens/main_app/product_details.dart';
import 'package:rev_rider/services/category_service.dart';
import 'package:rev_rider/services/product_service.dart';
import 'package:rev_rider/widgets/category_horizontal_listview.dart';
import 'package:rev_rider/widgets/product_gridview.dart';

class HomeScreen extends StatefulWidget {
  static final id = "HomeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Classes
  ProductService productServices = ProductService();
  CategoryService categoryServices = CategoryService();
  //Classes

// CategoryList Map Which contains { categoryDocumentID: CategoryName }
  Map categoryList = {};

// This categoryDocumentID List From Firebase will be added to this List
  List? listedCategoryIds;

// This categoryNames List From Firebase will be added to this List
  List? listedCategoryNames;

// this is the Index Of category list of the selectedcategory in CategoryHorizontalListview Widget
  String? selectedCategory;

  void initState() {
    fetchCategories();
    super.initState();
  }

// this Function used for Fetch all the categories in the Application
// it's used in this file because of setState() function

  void fetchCategories() async {
    Map<String, String> categories = await categoryServices.getCategory();
    setState(() {
      categoryList = categories;
      listedCategoryIds = categories.keys.toList();
      listedCategoryNames = categories.values.toList();
    });
  }

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
                //All Categories in Horizontal List
                child: CategoryHorizontalListview(
                  itemCount: categoryList.length,
                  listedCategoryName: listedCategoryNames ?? [],
                  onTap: (index) {
                    selectedCategory = listedCategoryIds![index];
                    print(selectedCategory);
                    setState(() {});
                  },
                ),
              ),
            ),

            // this is the area that can CategoryHorizontalListview exists

            Expanded(
              child: FutureBuilder<QuerySnapshot>(
                future: productServices.getProductsByCategory(
                    selectedCategory: selectedCategory),
                builder: (context, snapshot) {
                  List<QueryDocumentSnapshot<Object?>>? docs =
                      snapshot.data?.docs;
                  return ProductGridview(
                      onProductTap: (index) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetails(
                                selectedItemId: docs?[index]['productID']),
                          ),
                        );
                      },
                      itemCount: docs?.length,
                      productName: 'itemName',
                      productDescription: 'description',
                      productList: docs);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
