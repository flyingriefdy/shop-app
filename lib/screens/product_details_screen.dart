import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';

import '../providers/products.dart';
import '../constants.dart';

class ProductDetailsScreen extends StatelessWidget {
  // #docregion ProductDetails-var
  static const routeName = '/product_details';
  // #enddocregion ProductDetails-var

  @override
  Widget build(BuildContext context) {
    // #docregion ProductDetails-arg
    final id = ModalRoute.of(context).settings.arguments as String;
    // #enddocregion ProductDetails-arg

    // #docregion build-var
    final product = Provider.of<Products>(
      context,
    ).findProductById(id);
    // #enddocregion build-var

    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                floating: true,
                pinned: false,
                snap: true,
              )
            ];
          },
          body: ProductDetailsColumn(product: product)),
    );
  }
}

class ProductDetailsColumn extends StatelessWidget {
  const ProductDetailsColumn({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 300,
                  child: Image.network(
                    product.imgUrl,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(blurRadius: 8, color: Colors.black26)
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(kDefaultRadius * 1.5),
                      topRight: Radius.circular(kDefaultRadius * 1.5),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(kDefaultPadding),
                        child: Text(
                          '${product.title}',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: kDefaultPadding / 2,
                            horizontal: kDefaultPadding),
                        child: Text(
                          '\$${product.price}',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(kDefaultPadding),
                        child: Text(
                          '$kLoremIpsum',
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
