import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  var uuid = new Uuid();

  /// A list of [Product].
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  /// Adds [Product] into [_orders].
  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
        0,
        OrderItem(
          id: uuid.v4(),
          amount: total,
          products: cartProducts,
          dateTime: DateTime.now(),
        ));
    notifyListeners();
  }

  /// Clears [Product] in [_orders].
  void clearOrder() {
    _orders = [];
    notifyListeners();
  }
}
