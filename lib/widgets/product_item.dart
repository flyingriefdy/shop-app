import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_details_screen.dart';
import '../providers/product.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // #docregion build-var
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    // #enddocregion build-var

    return GridTile(
      child: GestureDetector(
        onTap: () => Navigator.of(context)
            .pushNamed(ProductDetailsScreen.routeName, arguments: product.id),
        child: Image.network(
          product.imgUrl,
          fit: BoxFit.fill,
        ),
      ),
      footer: GridTileBar(
        leading: Consumer<Product>(
            builder: (context, value, child) => IconButton(
                  icon: Icon(product.isFavourite
                      ? Icons.favorite
                      : Icons.favorite_border),
                  onPressed: () => product.toggleFavourite(),
                )),
        backgroundColor: Colors.black26,
        title: Text(
          product.title,
          textAlign: TextAlign.center,
        ),
        trailing: IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () => cart.addItem(
            product.id,
            product.title,
            product.price,
            product.imgUrl,
          ),
        ),
      ),
    );
  }
}
