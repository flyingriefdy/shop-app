import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './product_item.dart';
import '../providers/products.dart';

class ProductGridView extends StatelessWidget {
  // #docregion ProductGridView-var
  final bool showFavourites;
  // #enddocregion ProductGridView-var

  const ProductGridView({
    Key key,
    @required this.showFavourites,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // #docregion build-var
    final productsData = Provider.of<Products>(context);
    final products =
        showFavourites ? productsData.favouriteItems : productsData.items;
    // #enddocregion build-var

    return GridView.builder(
      itemCount: products.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: products[index],
        child: ProductItem(),
      ),
    );
  }
}
