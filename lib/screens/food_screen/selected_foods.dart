import 'package:fast_food_shop/screens/food_screen/elements/add_to_cart_button.dart';
import 'package:fast_food_shop/screens/food_screen/elements/product_quantity.dart';
import 'package:flutter/material.dart';

import 'elements/app_bar_selected_food.dart';
import 'elements/custom_name.dart';
import 'elements/selected_food_image.dart';

class SellectedFood extends StatefulWidget {
  final imagePath, foodName, price, heroTag, details;

  SellectedFood(
      {required this.imagePath,
      required this.foodName,
      required this.heroTag,
      required this.price,
      required this.details});

  @override
  _SellectedFoodState createState() => _SellectedFoodState();
}

class _SellectedFoodState extends State<SellectedFood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 90,
            child: Container(
              height: MediaQuery.of(context).size.height - 45,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: [
                  AppBarForSelectedFood(),
                  CustomName(text: "CRAZY"),
                  CustomName(text: widget.foodName.toString().toUpperCase()),
                  SizedBox(height: 40),
                  SelectedFoodImage(
                    imagePath: widget.imagePath,
                    heroTag: widget.heroTag,
                  ),
                  SizedBox(height: 10),
                  ProductQuantity(
                      price: widget.price, foodName: widget.foodName),
                  details(),
                  // I will put here product details
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Container(
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            child: Container(
                              child: Text(
                                widget.details,
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: AddToCartButton(
                foodName: widget.foodName,
                price: widget.price,
                imagePath: widget.imagePath),
          )
        ],
      ),
    );
  }

  Padding details() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        "DETAILS",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
