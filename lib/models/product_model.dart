class ProductModel {
  final String? productID;
  final String? itemName;
  final bool isAvaliable;
  final double? price;
  final String? description;
  final String? imageUrl;

  ProductModel(
      {required this.productID,
      required this.itemName,
      required this.isAvaliable,
      required this.price,
      required this.description,
      required this.imageUrl});

  Map<String, dynamic> productInfo() {
    return {
      "productID": productID,
      "itemName": itemName,
      "isAvaliable": isAvaliable,
      "price": price,
      "description": description,
      "imageUrl": imageUrl,
    };
  }
}
