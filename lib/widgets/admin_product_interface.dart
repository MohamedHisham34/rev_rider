// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rev_rider/models/product_model.dart';
import 'package:rev_rider/services/product_service.dart';

class AdminProductInterface extends StatelessWidget {
  final AsyncSnapshot snapshot;

  AdminProductInterface({super.key, required this.snapshot});

  final ProductService _productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          padding: EdgeInsets.all(12),
          itemCount: snapshot.data?.docs.length ?? 0,
          itemBuilder: (context, index) {
            final doc = snapshot.data!.docs[index];
            final itemName =
                doc[ProductModel.firebaseField_itemName] ?? "No Name";
            final description =
                doc[ProductModel.firebaseField_description] ?? "No Description";
            final price = doc[ProductModel.firebaseField_price] ?? 0;

            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.shopping_bag,
                          size: 32, color: Colors.blueAccent),
                      title: Text(itemName,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 6),
                          Text(description, style: TextStyle(fontSize: 14)),
                          SizedBox(height: 6),
                          Text("Price: ₹${price.toString()}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => _showEditDialog(context, index),
                          icon: Icon(Icons.edit, size: 18),
                          label: Text("Edit"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton.icon(
                          onPressed: () => _productService.deleteProductByAdmin(
                              snapshot, index),
                          icon: Icon(Icons.delete_outline, size: 18),
                          label: Text("Delete"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, int index) {
    final item = snapshot.data!.docs[index];
    final nameController =
        TextEditingController(text: item[ProductModel.firebaseField_itemName]);
    final descController = TextEditingController(
        text: item[ProductModel.firebaseField_description]);
    final priceController = TextEditingController(
        text: item[ProductModel.firebaseField_price].toString());

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title:
            Text("Edit Product", style: TextStyle(fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildInputField("Item Name", nameController),
              SizedBox(height: 12),
              _buildInputField("Description", descController),
              SizedBox(height: 12),
              _buildInputField("Price", priceController, isNumber: true),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              _productService.updateProductByAdmin(
                snapshot: snapshot,
                index: index,
                updatedItemName: nameController.text,
                updatedItemDescription: descController.text,
                updatedItemPrice: double.tryParse(priceController.text) ?? 0,
              );
              Navigator.pop(context);
            },
            child: Text("Update"),
          )
        ],
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller,
      {bool isNumber = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber
          ? TextInputType.numberWithOptions(decimal: true)
          : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      ),
    );
  }
}
