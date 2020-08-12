import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/manage_product_screen.dart';

import '../widgets/screen_title.dart';
import '../providers/products.dart';
import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';

/// A widget for user to add, edit, delete products
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
            onPressed: () =>
                Navigator.of(context).pushNamed(ManageProductScreen.routeName),
          )
        ],
      ),
      body: UserProductScreenBody(productData: productData),
    );
  }
}

class UserProductScreenBody extends StatelessWidget {
  const UserProductScreenBody({
    Key key,
    @required this.productData,
  }) : super(key: key);

  final Products productData;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                imgUrl: productData.items[index].imgUrl,
                id: productData.items[index].id,
              ),
              Divider()
            ]);
          },
        ))
      ],
    );
  }
}
