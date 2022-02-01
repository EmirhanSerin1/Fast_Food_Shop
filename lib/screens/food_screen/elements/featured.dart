import 'package:flutter/material.dart';

import '../selected_foods.dart';

buildList(String imagePath, String foodName, String price, BuildContext context) {
  return Padding(
    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap:() {
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
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            foodName,
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "\$" + price,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFF68D7F),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        )
      ],
    ),
  );
}