import 'dart:ui';

import 'package:fast_food_shop/screens/food_screen/selected_foods.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class CheapestTabs extends StatefulWidget {
  const CheapestTabs({Key key}) : super(key: key);

  @override
  _CheapestTabsState createState() => _CheapestTabsState();
}

class _CheapestTabsState extends State<CheapestTabs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          _buildListItem("Crazy Donut", 3, "5", "7", "assets/food/donut.png"),
          _buildListItem("Crazy Popcorn", 3, "3", "6", "assets/food/popcorn.png"),
        ],
      ),
    );
  }

  _buildListItem(String foodName, double rating, String price, String oldPrice, String imagePath) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
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
                child: Hero(
                  tag: foodName,
                  child: Container(
                    height: 75,
                    width: 75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Color(0xFFFFE3DF),
                    ),
                    child: Center(
                      child: Image.asset(
                        imagePath,
                        height: 70,
                        width: 70,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    foodName,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  SmoothStarRating(
                    allowHalfRating: false,
                    starCount: rating.toInt(),
                    rating: rating,
                    color: Color(0xFFFFD143),
                    borderColor: Color(0xFFFFD143),
                    size: 15,
                    spacing: 0,
                  ),
                  Row(
                    children: [
                      Text(
                        "\$" + price,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFF68D7F),
                        ),
                      ),
                      SizedBox(width: 3),
                      Text(
                        "\$" + oldPrice,
                        style: TextStyle(
                            fontSize: 14, decoration: TextDecoration.lineThrough, fontWeight: FontWeight.w600, color: Colors.grey.withOpacity(0.4)),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: Color(0xFFFD6750),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 5,
                    offset: Offset(2, 3),
                  ),
                ],
              ),
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
    );
  }
}
