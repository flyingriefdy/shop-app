import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static final routeName = '/order';
  @override
  Widget build(BuildContext context) {
    // The current orders
    final orders = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) =>
                OrderCard(orders: orders, index: index),
            itemCount: orders.orders.length,
          ))
        ],
      ),
    );
  }
}
