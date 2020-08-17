import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/screen_title.dart';

/// A widget to display [Orders]. [Orders] are purchase [Cart] items.
class OrdersScreen extends StatelessWidget {
  static final routeName = '/order';

  /// Here is an exercise to use a stateless widget that uses FutureBuilder
  /// to manage future. By doing this, you will not be required to manage
  /// state in InitState to load your initial values like [fetchOrders].
  /// This simplifies the process of managing future. Benefits you get is
  /// a leaner code and to not rebuild your widget trees.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: FutureBuilder(
          future: Provider.of<Orders>(context, listen: false).fetchOrders(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.error != null) {
                /// ...
                /// Error handling.
                return Center(
                  child: Text('An error has occured!'),
                );
              } else {
                return Consumer<Orders>(
                  builder: (context, orders, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ScreenTitle(title: 'Orders'),
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) =>
                                OrderCard(orders: orders, index: index),
                            itemCount: orders.orders.length,
                          ),
                        )
                      ],
                    );
                  },
                );
              }
            }
          },
        ));
  }
}
