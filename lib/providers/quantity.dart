import 'package:flutter/material.dart';

class Quantity with ChangeNotifier {
  var _quantity = 0;

  get quantity => _quantity;

  increaseQuantity() {
    _quantity++;
    notifyListeners();
  }

  decreaseQuantity() {
    _quantity -= 1;
    notifyListeners();
  }

  deleteQuantity() {
    _quantity = 0;
    notifyListeners();
  }

}
