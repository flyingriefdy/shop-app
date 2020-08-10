import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';

import '../providers/products.dart';

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
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        child: ProductDetailsColumn(product: product),
      ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
          padding: const EdgeInsets.all(16.0),
          child: Text(
            product.title,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Divider(),
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            '\$${product.price}',
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            '\${product.description}',
          ),
        ),
      ],
    );
  }
}
