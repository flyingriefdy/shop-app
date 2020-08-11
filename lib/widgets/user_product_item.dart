import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/manage_product_screen.dart';
import '../providers/products.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String imgUrl;
  final String id;

  UserProductItem(
      {@required this.title, @required this.imgUrl, @required this.id});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imgUrl),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.of(context)
                .pushNamed(ManageProductScreen.routeName, arguments: id),
          ),
          IconButton(
              icon: Icon(Icons.delete, color: Theme.of(context).errorColor),
              onPressed: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Are you sure?'),
                      content:
                          Text('Do you want to delete item from your shop?'),
                      actions: <Widget>[
                        FlatButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text('No')),
                        FlatButton(
                            onPressed: () {
                              Provider.of<Products>(context, listen: false)
                                  .deleteProductById(id);
                              Navigator.of(context).pop(true);
                            },
                            child: Text('Yes'))
                      ],
                    ),
                  ))
        ],
      ),
    );
  }
}
