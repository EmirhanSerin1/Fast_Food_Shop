import 'package:fast_food_shop/models/product.dart';
import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();

  List<Product> itemsList = [];
  List<Product> newList = [];
  void setItems(items) {
    itemsList = items;
  }

  void onSearch() {
    print(nameController.text.trim());

    newList = itemsList
        .where(
          (element) => element.name
              .toLowerCase()
              .contains(nameController.text.toLowerCase()),
        )
        .toList();

    print(itemsList);
    notifyListeners();
    print(newList);
  }
}
