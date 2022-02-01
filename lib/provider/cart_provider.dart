

import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier{

int _quantity = 0;
int get quantity => _quantity;

double _netPrice = 0;
double get netPrice => _netPrice;


addQuantity(pressed){
    switch (pressed) {
      case "ADD":
       _quantity++;
        _netPrice++;
        return;
      case "REMOVE":
          if (quantity > 0) {
            _quantity -= 1;
            _netPrice -= 1;
          }
        
        return;
    }
    notifyListeners();
}


}