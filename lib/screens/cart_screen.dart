import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/cart_item.dart';

import '../providers/cart.dart';
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  /// Screen to show the items in the cart

  static const routeName = '/cart_screen';
  @override
  Widget build(BuildContext context) {
    // The current cart
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(title: (Text('Cart'))),
      body: Column(
        children: <Widget>[
          // Card displays cart items
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total: ',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Spacer(),
                  Chip(
                      label: Text(
                    '\$${cart.totalAmount.toStringAsFixed(2)}',
                  )),
                  FlatButton(
                      onPressed: () {
                        Provider.of<Orders>(context, listen: false).addOrder(
                          cart.items.values.toList(),
                          cart.totalAmount,
                        );
                        cart.clear();
                      },
                      child: Text('Order Now'))
                ],
              ),
            ),
          ),
          CartCard(cart: cart)
        ],
      ),
    );
  }
}
