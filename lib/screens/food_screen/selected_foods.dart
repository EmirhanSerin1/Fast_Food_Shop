import 'dart:ui';

import 'package:flutter/material.dart';

import 'elements/featured.dart';
import 'elements/like_return.dart';

class SellectedFood extends StatefulWidget {
  final imagePath, foodName, price, heroTag;

  SellectedFood({this.imagePath, this.foodName, this.heroTag, this.price});

  @override
  _SellectedFoodState createState() => _SellectedFoodState();
}

class _SellectedFoodState extends State<SellectedFood> {
  var netPrice = 0;
  var quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  splashRadius: 30,
                  splashColor: Color(0xFFF56953).withOpacity(0.2),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                ),
                Stack(
                  children: [
                    Container(
                      height: 45,
                      width: 45,
                      color: Colors.transparent,
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFF56953).withOpacity(0.35),
                            blurRadius: 6,
                            spreadRadius: 4,
                            offset: Offset(1, 4),
                          ),
                        ],
                        color: Color(0xFFF56953),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 1,
                      right: 4,
                      child: Container(
                        height: 12,
                        width: 12,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            "1",
                            style: TextStyle(fontSize: 9, color: Color(0xFFF56953)),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 0, 0),
            child: Text(
              "CRAZY",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              widget.foodName.toString().toUpperCase(),
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Hero(
                tag: widget.heroTag,
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage(widget.imagePath),
                    fit: BoxFit.contain,
                  )),
                ),
              ),
              SizedBox(width: 15),
              buildLikeandReturn()
            ],
          ),
          SizedBox(height: 10),
          buildPrice(),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "FEATURED",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            height: 230,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Column(
                  children: [
                    buildList("assets/food/donut.png", "Crazy Donut    ", "5"),
                    buildList("assets/food/popcorn.png", "Crazy Popcorn", "3"),
                  ],
                ),
                Column(
                  children: [
                    buildList("assets/food/cheeseburgers.png", "Crazy Cheeseburger", "15"),
                    buildList("assets/food/pizza.png", "Crazy Pizza               ", "8"),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Row buildPrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 70,
          width: 120,
          color: Colors.white,
          child: Center(
            child: Text(
              "\$" + (int.parse(widget.price) * quantity).toString(),
              style: TextStyle(
                fontSize: 40,
                color: Color(0xFF484A4E),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        buildAddToCart()
      ],
    );
  }

  buildAddToCart() {
    return Container(
      height: 60,
      width: 225,
      decoration: BoxDecoration(
          color: Color(0xFFF56953),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 40,
            width: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      addQuantity("REMOVE");
                    },
                    icon: Icon(
                      Icons.remove,
                      color: Color(0xFFF56953),
                    )),
                Text(
                  netPrice.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFF56953),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      addQuantity("ADD");
                    },
                    icon: Icon(
                      Icons.add,
                      color: Color(0xFFF56953),
                    )),
              ],
            ),
          ),
          Text(
            "Add to cart",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  addQuantity(pressed) {
    switch (pressed) {
      case "ADD":
        setState(() {
          quantity += 1;
          netPrice += 1;
        });
        return;
      case "REMOVE":
        setState(() {
          if (quantity != 0) {
            quantity -= 1;
            netPrice -= 1;
          }
        });
        return;
    }
  }
}
