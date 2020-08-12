import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart';
import '../constants.dart';

class OrderCard extends StatefulWidget {
  const OrderCard({Key key, @required this.orders, @required this.index})
      : super(key: key);

  final int index;
  final Orders orders;

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  /// [_isExpanded] expands list tile.
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(
            top: kDefaultPadding, bottom: kDefaultPadding),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(
                'Order #${widget.orders.orders[widget.index].id}',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(color: Colors.blue),
              ),
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
                                    Expanded(
                                      child: Text(
                                        e.title,
                                        softWrap: true,
                                      ),
                                    ),
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
      ),
    );
  }
}
