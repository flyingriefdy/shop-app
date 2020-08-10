import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/products_grid_view.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import 'cart_screen.dart';
import '../widgets/app_drawer.dart';

enum FilterOptions {
  Favourites,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  static final routeName = '/product_overview';

  @override
  _ProductOverviewStateScreen createState() => _ProductOverviewStateScreen();
}

class _ProductOverviewStateScreen extends State<ProductOverviewScreen> {
  var _showOnlyFavourites = false;

  @override
  Widget build(BuildContext context) {
    // #docregion ProductOverviewScreen-var
    // #enddocregion ProductOverviewScreen-var

    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: <Widget>[
          PopupMenuButton(
              onSelected: (FilterOptions selectedValue) => setState(
                    () => selectedValue == FilterOptions.Favourites
                        ? _showOnlyFavourites = true
                        : _showOnlyFavourites = false,
                  ),
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text('Show Favourites'),
                      value: FilterOptions.Favourites,
                    ),
                    PopupMenuItem(
                      child: Text('Show All'),
                      value: FilterOptions.All,
                    ),
                  ]),
          Consumer<Cart>(
            builder: (context, cart, child) => Badge(
              child: child,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () =>
                  Navigator.of(context).pushNamed(CartScreen.routeName),
            ),
          )
        ],
      ),
      body: ProductGridView(showFavourites: _showOnlyFavourites),
      drawer: AppDrawer(),
    );
  }
}