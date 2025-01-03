class ProductModel {
  final String? productID;
  final String? itemName;

  final double? price;
  final String? description;
  final String? imageUrl;
  final int? stock;
  final String? productCategory;

  ProductModel({
    required this.productID,
    required this.itemName,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.stock,
    required this.productCategory,
  });

  Map<String, dynamic> productInfo() {
    return {
      "productID": productID,
      "itemName": itemName,
      "price": price,
      "description": description,
      "imageUrl": imageUrl,
      "stock": stock,
      "productCategory": productCategory,
    };
  }
}
