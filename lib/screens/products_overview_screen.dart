import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/products_grid_view.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import 'cart_screen.dart';
import '../widgets/app_drawer.dart';
import '../providers/products.dart';

enum FilterOptions {
  Favourites,
  All,
}

/// A widget to display [Products].
class ProductOverviewScreen extends StatefulWidget {
  static final routeName = '/product_overview';

  @override
  _ProductOverviewStateScreen createState() => _ProductOverviewStateScreen();
}

class _ProductOverviewStateScreen extends State<ProductOverviewScreen> {
  var _showOnlyFavourites = false;

  @override
  void initState() {
    // Provider.of<Products>(context).fetchProducts();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Provider.of<Products>(context).fetchProducts();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[buildSliverAppBar(context)];
        },
        body: ProductGridView(showFavourites: _showOnlyFavourites),
      ),
    );
  }

  SliverAppBar buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: false,
      snap: true,
      actions: <Widget>[
        PopupMenuButton(
            onSelected: (FilterOptions selectedValue) => setState(
                  () => selectedValue == FilterOptions.Favourites
                      ? _showOnlyFavourites = true
                      : _showOnlyFavourites = false,
                ),
            icon: Icon(Icons.filter_list),
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
    );
  }
}
