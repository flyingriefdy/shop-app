import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './product_item.dart';
import '../providers/products.dart';
import '../constants.dart';
import '../widgets/screen_title.dart';

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ScreenTitle(
          title: 'Products',
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(kDefaultPadding),
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 2 / 4,
              crossAxisCount: 2,
              mainAxisSpacing: kDefaultPadding,
              crossAxisSpacing: kDefaultPadding,
            ),
            itemBuilder: (context, index) => ChangeNotifierProvider.value(
              value: products[index],
              child: ProductItem(),
            ),
          ),
        ),
      ],
    );
  }
}
