import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imgUrl;
  bool isFavourite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imgUrl,
    this.isFavourite = false,
  });

  /// Toggles favourite [Product].
  Future<void> toggleFavourite() async {
    isFavourite = !isFavourite;
    final url =
        'https://shop-app-41dfd.firebaseio.com/products/${this.id}.json';
    final response = await http.patch(url,
        body: json.encode({
          'title': this.title,
          'description': this.description,
          'price': this.price,
          'imgUrl': this.imgUrl,
          'isFavourite': isFavourite,
        }));

    if (response.statusCode >= 400) {
      isFavourite = !isFavourite;
      throw HttpException('Could not toggle item to favourite');
    }

    notifyListeners();
  }
}
