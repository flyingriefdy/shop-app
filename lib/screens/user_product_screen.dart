import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/screen_title.dart';
import '../constants.dart';
import '../providers/products.dart';
import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';

class UserProductsScreen extends StatelessWidget {
  static final routeName = '/my_shop';
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => null,
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ScreenTitle(title: 'Your Products'),
          Expanded(
              child: ListView.builder(
            itemCount: productData.items.length,
            itemBuilder: (context, index) {
              return Column(children: [
                UserProductItem(
                    title: productData.items[index].title,
                    imgUrl: productData.items[index].imgUrl),
                Divider()
              ]);
            },
          ))
        ],
      ),
    );
  }
}
