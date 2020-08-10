import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_details_screen.dart';
import '../providers/product.dart';
import '../providers/cart.dart';
import '../constants.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // #docregion build-var
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    // #enddocregion build-var

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(
                ProductDetailsScreen.routeName,
                arguments: product.id),
            child: Card(
              elevation: 0.0,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kDefaultRadius)),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints.expand(),
                    child: Image.network(
                      product.imgUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 8.0,
                    child: Row(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 4,
                                    offset: Offset(2, 2),
                                    color: Colors.black12)
                              ]),
                          child: IconButton(
                            icon: product.isFavourite
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : Icon(Icons.favorite_border),
                            onPressed: () => product.toggleFavourite(),
                          ),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 8,
                                    offset: Offset(2, 2),
                                    color: Colors.black12)
                              ]),
                          child: IconButton(
                              icon: Icon(Icons.shopping_cart),
                              onPressed: () => cart.addItem(
                                    product.id,
                                    product.title,
                                    product.price,
                                    product.imgUrl,
                                  )),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 4),
          child: Text(
            product.title,
            style: Theme.of(context).textTheme.caption,
          ),
        ),
        Text(
          '\$${product.price}',
          style: Theme.of(context).textTheme.bodyText1,
        )
      ],
    );

    // ClipRRect(
    //   borderRadius: BorderRadius.circular(8.0),
    //   child: GridTile(
    //     child: GestureDetector(
    //       onTap: () => Navigator.of(context)
    //           .pushNamed(ProductDetailsScreen.routeName, arguments: product.id),
    //       child: Image.network(
    //         product.imgUrl,
    //         fit: BoxFit.fill,
    //       ),
    //     ),
    //     footer: GridTileBar(
    //       leading: Consumer<Product>(
    //           builder: (context, value, child) => IconButton(
    //                 icon: Icon(product.isFavourite
    //                     ? Icons.favorite
    //                     : Icons.favorite_border),
    //                 onPressed: () => product.toggleFavourite(),
    //               )),
    //       backgroundColor: Colors.black26,
    //       title: Text(
    //         product.title,
    //         textAlign: TextAlign.center,
    //       ),
    //       trailing: IconButton(
    //         icon: Icon(Icons.shopping_cart),
    //         onPressed: () => cart.addItem(
    //           product.id,
    //           product.title,
    //           product.price,
    //           product.imgUrl,
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
