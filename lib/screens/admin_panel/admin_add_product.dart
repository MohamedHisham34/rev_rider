import 'package:flutter/material.dart';
import 'package:rev_rider/services/category_service.dart';
import 'package:rev_rider/widgets/admin_add_product_interface.dart';
import 'package:rev_rider/widgets/reusable_future_builder.dart';

class AdminAddProduct extends StatefulWidget {
  const AdminAddProduct({super.key});

  @override
  State<AdminAddProduct> createState() => _AdminAddProductState();
}

class _AdminAddProductState extends State<AdminAddProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('AdminProductScreen'),
        ),
        body: ReusableFutureBuilder(
          future: categoriesReference.get(),
          content: (snapshot) {
            return AdminAddProductInterface(snapshot: snapshot);
          },
        ));
  }
}
