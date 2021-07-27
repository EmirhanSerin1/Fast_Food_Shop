import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class FoodTab extends StatefulWidget {
  const FoodTab({Key key}) : super(key: key);

  @override
  _FoodTabState createState() => _FoodTabState();
}

class _FoodTabState extends State<FoodTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [_buildListItem("Hot Hot Dog", 4, "6", "assets/food/hotdog.png")],
      ),
    );
  }

  _buildListItem(String foodName, double rating, String price, String imagePath) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
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
                        "\$" + "18",
                        style: TextStyle(
                            fontSize: 14, decoration: TextDecoration.lineThrough, fontWeight: FontWeight.w600, color: Colors.grey.withOpacity(0.4)),
                      ),
                    ],
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
