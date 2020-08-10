import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../constants.dart';

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
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
              vertical: kDefaultPadding,
            ),
            child: Text(
              "Orders",
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
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
