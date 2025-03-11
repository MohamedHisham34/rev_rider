// ignore_for_file: constant_identifier_names

enum OrderState {
  delivering,
  shipping,
  canceled,
}

String orderID2 = "orderID";

class OrderModel {
  static const String firebaseField_orderID = 'orderID';
  static const String firebaseField_orderTotalPrice = 'orderTotalPrice';
  static const String firebaseField_numberOfItems = 'numberOfItems';
  static const String firebaseField_orderAddress = 'orderAddress';
  static const String firebaseField_orderPlacedBy = 'orderPlacedBy';
  static const String firebaseField_orderState = 'orderState';

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
      firebaseField_orderID: orderID,
      firebaseField_orderTotalPrice: orderTotalPrice,
      firebaseField_numberOfItems: numberOfItems,
      firebaseField_orderAddress: orderAddress,
      firebaseField_orderState: orderState.name,
      firebaseField_orderPlacedBy: orderPlacedBy,
    };
  }
}
