import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
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
  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    const url = 'https://shop-app-41dfd.firebaseio.com/orders.json';

    try {
      /// Post HTTP request to URL.
      final response = await http.post(url,
          body: json.encode({
            'amount': total,
            'dateTime': DateTime.now().toIso8601String(),
            'products': cartProducts
                .map((e) => {
                      'id': e.id,
                      'title': e.title,
                      'quantity': e.quantity,
                      'price': e.price,
                      'imgUrl': e.imgUrl,
                    })
                .toList()
          }));

      /// Insert [OrderItem] into [_orders].
      _orders.insert(
          0,
          OrderItem(
            id: json.decode(response.body)['name'],
            amount: total,
            products: cartProducts,
            dateTime: DateTime.now(),
          ));

      /// Notify listeners to new changes.
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }

  /// Clears [Product] in [_orders].
  void clearOrder() {
    _orders = [];
    notifyListeners();
  }

  /// Fetches Order
  Future<void> fetchOrders() async {
    const url = 'https://shop-app-41dfd.firebaseio.com/orders.json';
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;

    /// Check is payload is empty.
    if (extractedData == null) {
      return;
    }

    /// Extract data and map.
    extractedData.forEach((key, value) {
      loadedOrders.add(OrderItem(
          id: key,
          amount: value['amount'],
          products: (value['products'] as List<dynamic>)
              .map((e) => CartItem(
                    id: e['id'],
                    title: e['title'],
                    quantity: e['quantity'],
                    price: e['price'],
                    imgUrl: e['imgUrl'],
                  ))
              .toList(),
          dateTime: DateTime.parse(
            value['dateTime'],
          )));
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }
}
