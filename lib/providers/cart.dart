import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String imgUrl;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
    @required this.imgUrl,
  });
}

class Cart with ChangeNotifier {
  /// A unique identifier generator.
  final uuid = Uuid();

  /// A map of [CartItem].
  Map<String, CartItem> _items = {};

  /// Returns list of [CartItems] in [_items].
  Map<String, CartItem> get items {
    return {..._items};
  }

  /// Returns [_items] count.
  int get itemCount {
    return _items.length;
  }

  /// Returns total amount in [_items].
  double get totalAmount {
    var total = 0.00;
    _items.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  /// Adds [Product] into [_items].
  void addItem(
    String productId,
    String title,
    double price,
    String imgUrl,
  ) {
    /// Add 1 quantity if [CartItem] exists in [_items].
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                quantity: existingCartItem.quantity + 1,
                price: existingCartItem.price,
                imgUrl: imgUrl,
              ));
    } else {
      /// Creates new [CartItem] add adds to [_items].
      _items.putIfAbsent(
          productId,
          () => CartItem(
                id: uuid.v1(),
                title: title,
                quantity: 1,
                price: price,
                imgUrl: imgUrl,
              ));
    }
    notifyListeners();
  }

  /// Removes [CartItem] from [_items].
  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  /// Clears all [CartItem] from [_items].
  void clear() {
    _items = {};
    notifyListeners();
  }

  /// Removes single quantity of [Product] in [_items].
  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantity > 1) {
      _items.update(
          productId,
          (value) => CartItem(
              id: value.id,
              title: value.title,
              quantity: value.quantity - 1,
              price: value.price,
              imgUrl: value.imgUrl));
    } else {
      _items.remove(productId);
    }

    notifyListeners();
  }
}
