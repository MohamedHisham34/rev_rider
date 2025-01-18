enum OrderState {
  delivering,
  shipping,
  canceled,
}

class OrderModel {
  final String? orderID;
  final double? orderTotalPrice;
  final int? numberOfItems;
  final String? orderAddress;
  final OrderState orderState;
  final String? orderPlacedBy;

  OrderModel(
      {required this.orderID,
      required this.orderTotalPrice,
      required this.numberOfItems,
      required this.orderAddress,
      required this.orderState,
      required this.orderPlacedBy});

  Map<String, dynamic> orderInfo() {
    return {
      "orderID": orderID,
      "orderTotalPrice": orderTotalPrice,
      "numberOfItems": numberOfItems,
      "orderAddress": orderAddress,
      "orderState": orderState.name,
      "orderPlacedBy": orderPlacedBy,
    };
  }
}
