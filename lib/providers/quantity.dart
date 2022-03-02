import 'package:flutter/material.dart';

class Quantity with ChangeNotifier {
  var _quantity = 1;

  get quantity => _quantity;

  increaseQuantity() {
    _quantity++;
    notifyListeners();
  }

  decreaseQuantity() {
    if (quantity > 1) {
      _quantity -= 1;
    }
    notifyListeners();
  }

  deleteQuantity() {
    _quantity = 1;
    notifyListeners();
  }
}
