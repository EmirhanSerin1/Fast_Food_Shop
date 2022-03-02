import 'package:flutter/material.dart';

import 'featured.dart';

class Featured extends StatelessWidget {
  const Featured({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Column(
            children: [
              buildList(
                  "assets/food/donut.png", "Crazy Donut    ", "5", context),
              buildList(
                  "assets/food/popcorn.png", "Crazy Popcorn", "3", context),
            ],
          ),
          Column(
            children: [
              buildList("assets/food/cheeseburgers.png", "Crazy Cheeseburger",
                  "15", context),
              buildList("assets/food/pizza.png", "Crazy Pizza               ",
                  "8", context),
            ],
          )
        ],
      ),
    );
  }
}
