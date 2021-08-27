import 'package:fast_food_shop/screens/burger/burger.dart';
import 'package:flutter/material.dart';

buildFoods(String foodName, String imagePath, String price, Color color, Color textColor, BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(left: 15),
    child: InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Burger(
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
        ),
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
                  child: Image.asset(
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
