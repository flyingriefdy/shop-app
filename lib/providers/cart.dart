import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:uuid/uuid.dart';

class CartItem {
  // #docregion CartItem-properties
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String imgUrl;
  //# enddocregion CartItem-properties

  // #docregion CartItem-constructor
  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
    @required this.imgUrl,
  });
  //# enddocregion CartItem-constructor

}

class Cart with ChangeNotifier {
  // #docregion Cart-var
  final uuid = Uuid();

  Map<String, CartItem> _items = {};
  // #enddocregion Cart-var

  // #docregion get items
  Map<String, CartItem> get items {
    return {..._items};
  }
  // #enddocregion get items

  // #docregion get itemCount
  int get itemCount {
    return _items.length;
  }
  // #enddocregion get itemCount

  // #docregion get totalAmount
  double get totalAmount {
    var total = 0.00;
    _items.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }
  // #enddocregion get totalAmount

  // #docregion addItem
  void addItem(
    String productId,
    String title,
    double price,
    String imgUrl,
  ) {
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
  // #enddocregion addItem

  // #docregion removeItem
  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }
  // #enddocregion removeItem

  void clear() {
    _items = {};
    notifyListeners();
  }

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
