import 'package:flutter/material.dart';
import 'product.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products with ChangeNotifier {
  /// The unique identifier generator.
  var uuid = Uuid();

  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imgUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imgUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imgUrl: 'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imgUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  List<Product> get items {
    return [..._items];
  }

  /// Adds [Product] to list. Sends PUT HTTP request to db and add
  /// new [Product].
  Future<void> addProduct(Product product) async {
    /// Firebase URL.
    const url = 'https://shop-app-41dfd.firebaseio.com/products.json';
    try {
      /// Post HTTP request to URL.
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imgUrl': product.imgUrl,
          'price': product.price,
          'isFavourite': product.isFavourite,
        }),
      );

      /// Creates new [Product].
      final newProduct = Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          description: product.description,
          price: product.price,
          imgUrl: product.imgUrl);

      /// Adds new [Product] to [_items].
      _items.add(newProduct);

      /// Notify listeners on new changes.
      notifyListeners();
    } catch (err) {
      print(err);
      throw err;
    }
  }

  /// Returns favourite list of [Product].
  List<Product> get favouriteItems {
    return _items.where((element) => element.isFavourite).toList();
  }

  /// Returns [Product] by Id.
  Product findProductById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  /// Removes [Product] by Id.
  void deleteProductById(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  /// Updates [Product] by Id.
  void updateProductById(String id, Product newProduct) {
    final productIndex = _items.indexWhere((element) => element.id == id);
    if (productIndex >= 0) {
      _items[productIndex] = newProduct;
      notifyListeners();
    }
  }

  Future<void> fetchProducts() async {
    const url = 'https://shop-app-41dfd.firebaseio.com/products.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      extractedData.forEach((key, value) {
        loadedProducts.add(Product(
            id: key,
            title: value['title'],
            description: value['description'],
            price: value['price'],
            imgUrl: value['imgUrl'],
            isFavourite: value['isFavourite']));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (err) {
      throw (err);
    }
  }
}
