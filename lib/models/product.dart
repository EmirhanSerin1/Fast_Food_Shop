import 'package:flutter/foundation.dart';

class Product {
  String? id;
  String name;
  String price;
  String image;

  Product({
    this.id,
    required this.name,
    required this.price,
    required this.image,
  });
}
