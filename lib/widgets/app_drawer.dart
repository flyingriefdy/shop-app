import 'package:flutter/material.dart';

import '../screens/products_overview_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/user_product_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text(
              'Menu',
              style: Theme.of(context).textTheme.headline6,
            ),
            automaticallyImplyLeading: false,
          ),
          AppDrawerListTile(
            iconData: Icons.shop,
            title: 'Shop',
            routeName: ProductOverviewScreen.routeName,
          ),
          AppDrawerListTile(
            iconData: Icons.payment,
            routeName: OrdersScreen.routeName,
            title: 'Orders',
          ),
          AppDrawerListTile(
              title: 'My Shop',
              routeName: UserProductsScreen.routeName,
              iconData: Icons.shop_two)
        ],
      ),
    );
  }
}

class AppDrawerListTile extends StatelessWidget {
  final String title;
  final String routeName;
  final IconData iconData;
  const AppDrawerListTile(
      {Key key,
      @required this.title,
      @required this.routeName,
      @required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(iconData),
      title: Text(title),
      onTap: () => Navigator.of(context).pushNamed(routeName),
    );
  }
}
