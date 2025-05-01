// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:rev_rider/main.dart';
import 'package:rev_rider/models/product_model.dart';
import 'package:rev_rider/screens/main_app/product_details.dart';
import 'package:rev_rider/screens/main_app/testing.dart';
import 'package:rev_rider/services/category_service.dart';
import 'package:rev_rider/services/product_service.dart';
import 'package:rev_rider/widgets/category_horizontal_listview.dart';
import 'package:rev_rider/widgets/drawer.dart';
import 'package:rev_rider/widgets/product_gridview.dart';
import 'package:rev_rider/widgets/reusable_future_builder.dart';

class HomeScreen extends StatefulWidget {
  static const id = "HomeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoryService categoryServices = CategoryService();

  // CategoryList Map Which contains { categoryDocumentID: CategoryName }
  Map categoryList = {};

  // This categoryDocumentID List From Firebase will be added to this List
  List? listedCategoryIds;

  // This categoryNames List From Firebase will be added to this List
  List? listedCategoryNames;

  // this is the Index Of category list of the selectedcategory in CategoryHorizontalListview Widget
  int selectedCategoryIndex = 0;
  String? selectedCategory;
  ProductService _productService = ProductService();

  void initState() {
    fetchCategories();
    super.initState();
  }

  // this Function used for Fetch all the categories in the Application
  // it's used in this file because of setState() function

  void fetchCategories() async {
    Map<String, String> categories = await categoryServices.getCategory();
    setState(
      () {
        categoryList = categories;
        listedCategoryIds = categories.keys.toList();
        listedCategoryNames = categories.values.toList();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: appDrawer(context: context),
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
                      "1",
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

      // START OF SCREEN CONTENT
      body: ListView(
        children: [
          // ADS SECTION
          AdsContainer(),
          SizedBox(height: 30),

          // PRODUCT SECTION
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Text("Category"),
                Container(
                  width: double.infinity,
                  height: 60,
                  child: Expanded(
                    child: CategoryHorizontalListview(
                      itemCount: categoryList.length,
                      listedCategoryName: listedCategoryNames ?? [],
                      selectedCategoryIndex: selectedCategoryIndex,
                      onTap: (index) {
                        selectedCategoryIndex = index;
                        selectedCategory = listedCategoryIds![index];
                        // selectedCategory = docs[Index].id;

                        setState(() {});
                      },
                    ),
                  ),
                ),

                // PRODUCTS
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
                          ),
                        );
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
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
    ),
    width: double.infinity,
    height: 150,
    child: Padding(
      padding: EdgeInsets.all(30),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: [0, 1],
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromRGBO(29, 186, 144, 1),
            ],
          ),
        ),
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
    ),
  );
}
