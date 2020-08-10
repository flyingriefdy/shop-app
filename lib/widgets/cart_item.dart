import 'package:flutter/material.dart';

import '../providers/cart.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) => Dismissible(
          onDismissed: (direction) =>
              cart.removeItem(cart.items.keys.toList()[index]),
          direction: DismissDirection.endToStart,
          key: ValueKey(cart.items.values.toList()[index].id),
          background: Container(
            color: Colors.red,
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 16.0),
          ),
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: ListTile(
              title: Text('${cart.items.values.toList()[index].title}'),
              subtitle: Row(
                children: <Widget>[
                  Text('${cart.items.values.toList()[index].quantity} x'),
                  Text(' \$${cart.items.values.toList()[index].price}'),
                  Spacer(),
                  Text(
                      'Subtotal: \$${cart.items.values.toList()[index].quantity * cart.items.values.toList()[index].price}'),
                ],
              ),
            ),
          ),
        ),
        itemCount: cart.items.length,
      ),
    );
  }
}
