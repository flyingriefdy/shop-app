import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/screen_title.dart';

/// A widget to display [Orders]. [Orders] are purchase [Cart] items.
class OrdersScreen extends StatefulWidget {
  static final routeName = '/order';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoaded = false;
  @override
  void initState() {
    /// A hack instead of using didDependenciesChanged.
    Future.delayed(Duration.zero).then((_) {
      Provider.of<Orders>(context, listen: false).fetchOrders();
      setState(() {
        _isLoaded = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// The current [Order].
    final orders = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(),
      body: !_isLoaded
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
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
