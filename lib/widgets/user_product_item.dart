import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String imgUrl;

  UserProductItem({
    @required this.title,
    @required this.imgUrl,
  });

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
            onPressed: () => null,
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Theme.of(context).errorColor),
            onPressed: () => null,
          )
        ],
      ),
    );
  }
}
