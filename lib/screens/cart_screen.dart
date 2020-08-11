import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/cart_item.dart';

import '../providers/cart.dart';
import '../providers/orders.dart';
import '../constants.dart';
import '../widgets/screen_title.dart';

class CartScreen extends StatelessWidget {
  /// Screen to show the items in the cart

  static const routeName = '/cart_screen';
  @override
  Widget build(BuildContext context) {
    // The current cart
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Provider.of<Orders>(context, listen: false).addOrder(
            cart.items.values.toList(),
            cart.totalAmount,
          );
          cart.clear();
        },
        label: Text('Order Now'),
      ),
      appBar: AppBar(),
      body: CartColumn(cart: cart),
    );
  }
}

class CartColumn extends StatelessWidget {
  const CartColumn({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ScreenTitle(title: 'Cart'),
          ],
        ),
        // Card displays cart items
        Card(
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  'Total: \$${cart.totalAmount.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ),
        ),
        CartCard(cart: cart)
      ],
    );
  }
}
