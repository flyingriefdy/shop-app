import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  // #docregion Product-prop
  final String id;
  final String title;
  final String description;
  final double price;
  final String imgUrl;
  bool isFavourite;
  // #enddocregion Product-prop

  // #docregion Product-constructor
  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imgUrl,
    this.isFavourite = false,
  });
  // #enddocregion Product-constructor

  // #docregion toggleFavourite
  void toggleFavourite() {
    isFavourite = !isFavourite;
    notifyListeners();
  }
  // #enddocregion toggleFavourite
}
