import 'package:fast_food_shop/screens/food_screen/selected_foods.dart';
import 'package:flutter/material.dart';

buildFoods(String foodName, String imagePath, String price, Color color,
    Color textColor, BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(left: 15, top: 4, bottom: 8),
    child: InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SellectedFood(
              foodName: foodName,
              price: price,
              imagePath: imagePath,
              heroTag: foodName,
            ),
          ),
        );
      },
      child: Container(
        height: 174,
        width: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: color,
            boxShadow: [
              BoxShadow(
                offset: const Offset(1, 3),
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 2,
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: foodName,
              child: Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.network(
                    imagePath,
                    height: 50,
                    width: 50,
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            Text(
              foodName,
              style: TextStyle(fontSize: 17, color: textColor),
            ),
            Text(
              "\$" + price,
              style: TextStyle(fontSize: 17, color: textColor),
            )
          ],
        ),
      ),
    ),
  );
}
