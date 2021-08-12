import 'package:flutter/material.dart';

class Burger extends StatefulWidget {
  final imagePath, foodName, price, heroTag;

  Burger({this.imagePath, this.foodName, this.heroTag, this.price});

  @override
  _BurgerState createState() => _BurgerState();
}

class _BurgerState extends State<Burger> {
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
                Icon(Icons.menu, color: Colors.black),
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
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
