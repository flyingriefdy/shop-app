import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/screen_title.dart';

class OrdersScreen extends StatelessWidget {
  static final routeName = '/order';
  @override
  Widget build(BuildContext context) {
    // The current orders
    final orders = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ScreenTitle(title: 'Orders'),
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
