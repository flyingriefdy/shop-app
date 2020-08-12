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
  /// Is loading.
  var _isLoading = false;
  var _isInit = true;

  /// Is to show favourite [Product].
  var _showOnlyFavourites = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
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
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ProductGridView(showFavourites: _showOnlyFavourites),
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
