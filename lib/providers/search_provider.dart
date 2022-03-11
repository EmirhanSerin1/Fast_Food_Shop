import 'package:fast_food_shop/models/product.dart';
import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  List<Product> itemsList = [];
  List<Product> newList = [];
  void setItems(items) {
    itemsList = items;
  }

  void onSearch(String name) {
    
      newList = itemsList
          .where((element) => element.name.toLowerCase().contains(name.toLowerCase()))
          .toList();
    
    print(name);
    print(itemsList);
    notifyListeners();
    print(newList);
  }
}
