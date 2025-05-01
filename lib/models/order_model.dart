// ignore_for_file: constant_identifier_names

enum OrderState {
  pending,
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
  static const String firebaseField_productsIds = 'productsIds';
  static const String firebaseField_paymentMethod = 'paymentMethod';

  final String? orderID;
  final double? orderTotalPrice;
  final int? numberOfItems;
  final String? orderAddress;
  final OrderState orderState;
  final String? orderPlacedBy;
  final String paymentMethod;
  final Map<String, int> productsIds;

  OrderModel(
      {required this.productsIds,
      required this.orderID,
      required this.orderTotalPrice,
      required this.numberOfItems,
      required this.orderAddress,
      required this.orderState,
      required this.paymentMethod,
      required this.orderPlacedBy});

  Map<String, dynamic> orderInfo() {
    return {
      firebaseField_orderID: orderID,
      firebaseField_orderTotalPrice: orderTotalPrice,
      firebaseField_numberOfItems: numberOfItems,
      firebaseField_orderAddress: orderAddress,
      firebaseField_orderState: orderState.name,
      firebaseField_orderPlacedBy: orderPlacedBy,
      firebaseField_paymentMethod: paymentMethod,
      firebaseField_productsIds: productsIds,
    };
  }
}
