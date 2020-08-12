import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/cart_item.dart';

import '../providers/cart.dart';
import '../providers/orders.dart';
import '../constants.dart';
import '../widgets/screen_title.dart';

/// A widget to display and manage [Cart] items. Users may delete [Cart] items
/// Users may purchase [Cart] items.
///
/// Purchased [Cart] items are pushed into [Orders].
class CartScreen extends StatelessWidget {
  static const routeName = '/cart_screen';
  @override
  Widget build(BuildContext context) {
    /// The current [Cart].
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: OrderFAB(cart: cart),
      appBar: AppBar(),
      body: CartBody(cart: cart),
    );
  }
}

class OrderFAB extends StatefulWidget {
  const OrderFAB({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderFABState createState() => _OrderFABState();
}

class _OrderFABState extends State<OrderFAB> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: widget.cart.totalAmount <= 0 || _isLoading
          ? Colors.grey
          : Theme.of(context).primaryColor,
      onPressed: widget.cart.totalAmount <= 0 || _isLoading
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });

              /// Adds [Cart] to [Order].
              try {
                await Provider.of<Orders>(context, listen: false).addOrder(
                  widget.cart.items.values.toList(),
                  widget.cart.totalAmount,
                );
                setState(() {
                  _isLoading = false;
                });

                /// Clears [Cart].
                widget.cart.clear();
              } catch (err) {}
            },
      label: _isLoading ? Text('Placing Order...') : Text('Order Now'),
    );
  }
}

class CartBody extends StatelessWidget {
  const CartBody({
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

        /// A card widget that displays [Cart] items.
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
