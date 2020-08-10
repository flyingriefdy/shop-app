import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart';

class OrderCard extends StatefulWidget {
  const OrderCard({Key key, @required this.orders, @required this.index})
      : super(key: key);

  final int index;
  final Orders orders;

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool _isExpanded = false;
  double _totalAmount = 0.00;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('Order #${widget.orders.orders[widget.index].id}'),
            subtitle: Text(
                '${DateFormat('dd/MM/yyyy hh:mm').format(widget.orders.orders[widget.index].dateTime)}'),
            trailing: IconButton(
              icon: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
          ),
          _isExpanded
              ? Column(
                  children: <Widget>[
                    ...ListTile.divideTiles(
                      tiles: widget.orders.orders[widget.index].products
                          .map(
                            (e) => ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(e.title),
                                  Spacer(),
                                  Text('${e.quantity}x \$${e.price}')
                                ],
                              ),
                            ),
                          )
                          .toList(),
                      context: context,
                    ),
                  ],
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
