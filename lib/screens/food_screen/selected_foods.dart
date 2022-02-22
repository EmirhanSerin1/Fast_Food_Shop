import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_food_shop/models/shooing_cart.dart';
import 'package:fast_food_shop/providers/set_doc_id.dart';
import 'package:fast_food_shop/screens/food_screen/elements/add_to_cart.dart';
import 'package:fast_food_shop/screens/food_screen/elements/featureditems.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'elements/app_bar_selected_food.dart';
import 'elements/custom_name.dart';
import 'elements/featured.dart';
import 'elements/selected_food_image.dart';

class SellectedFood extends StatefulWidget {
  final imagePath, foodName, price, heroTag;

  SellectedFood({this.imagePath, this.foodName, this.heroTag, this.price});

  @override
  _SellectedFoodState createState() => _SellectedFoodState();
}

class _SellectedFoodState extends State<SellectedFood> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ListView(
        children: [
          AppBarForSelected(),
          CustomName(text: "CRAZY"),
          CustomName(text: widget.foodName.toString().toUpperCase()),
          SizedBox(height: 40),
          SelectedFoodImage(imagePath: widget.imagePath, heroTag: widget.heroTag),
          SizedBox(height: 10),
          AddToCard(foodName: widget.foodName, imagePath: widget.imagePath, price: widget.price),
          featured(),
          featuredItems(context),
        ],
      ),
    );
  }

  Padding featured() {
    return Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            "FEATURED",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        );
  }

 
  

 

 
}



