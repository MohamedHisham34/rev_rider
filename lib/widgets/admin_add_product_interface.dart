// ignore_for_file: prefer_const_constructors

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rev_rider/constants/colors.dart';
import 'package:rev_rider/models/product_model.dart';
import 'package:rev_rider/services/product_service.dart';

class AdminAddProductInterface extends StatefulWidget {
  final AsyncSnapshot snapshot;

  const AdminAddProductInterface({super.key, required this.snapshot});

  @override
  State<AdminAddProductInterface> createState() =>
      _AdminAddProductInterfaceState();
}

class _AdminAddProductInterfaceState extends State<AdminAddProductInterface> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();

  String productId = Random().nextInt(999999999).toString();
  String? selectedCategory;

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  void _addProduct() {
    if (!_formKey.currentState!.validate()) return;

    final product = ProductModel.addProductToApp(
      productID: productId,
      itemName: _nameController.text,
      price: double.tryParse(_priceController.text),
      description: _descController.text,
      imageUrl: null,
      stock: int.tryParse(_stockController.text),
      productCategory: selectedCategory,
    );

    productReference.doc(productId).set(product.productInfo());
  }

  @override
  Widget build(BuildContext context) {
    final categories = widget.snapshot.data?.docs ?? [];

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Card(
          elevation: 6,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add New Product",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildTextField(
                    controller: _nameController,
                    label: "Item Name",
                    hint: "Enter item name",
                    validatorMsg: "Name required",
                  ),
                  SizedBox(height: 15),
                  _buildTextField(
                    controller: _descController,
                    label: "Description",
                    hint: "Enter description",
                    validatorMsg: "Description required",
                    maxLines: 3,
                  ),
                  SizedBox(height: 15),
                  _buildTextField(
                    controller: _priceController,
                    label: "Price",
                    hint: "Enter price",
                    validatorMsg: "Enter a valid number",
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    isDouble: true,
                  ),
                  SizedBox(height: 15),
                  _buildTextField(
                    controller: _stockController,
                    label: "Stock",
                    hint: "Enter number of items",
                    validatorMsg: "Enter a valid quantity",
                    keyboardType: TextInputType.number,
                    isInt: true,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Category",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: selectedCategory,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    ),
                    items: categories.map<DropdownMenuItem<String>>((doc) {
                      return DropdownMenuItem<String>(
                        value: doc.id,
                        child: Text(doc['name']),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() => selectedCategory = value);
                    },
                    validator: (value) =>
                        value == null ? "Please select a category" : null,
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: _addProduct,
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: PrimaryOrangeColor,
                      ),
                      child: Text(
                        "ADD PRODUCT",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required String validatorMsg,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    bool isDouble = false,
    bool isInt = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) return validatorMsg;
            if (isDouble && double.tryParse(value) == null)
              return "Enter a valid number";
            if (isInt && int.tryParse(value) == null)
              return "Enter a valid integer";
            return null;
          },
        ),
      ],
    );
  }
}
