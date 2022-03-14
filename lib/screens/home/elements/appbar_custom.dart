import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_food_shop/core/profiile_photo/profil_photo.dart';
import 'package:fast_food_shop/screens/drawer/screensInDrawer/my_account/my_account.dart';
import 'package:fast_food_shop/screens/food_screen/elements/app_bar_selected_food.dart';
import 'package:fast_food_shop/screens/shopping_cart/shopping_cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

buildCustomAppbar(BuildContext context) {
  return Padding(
    padding: EdgeInsets.all(15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Builder(
          builder: (context) => Container(
            alignment: Alignment.center,
            child: IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: Icon(Icons.menu),
              color: Colors.black,
            ),
          ),
        ),
        Row(
          children: [
            buildShopBoxCircleForAppBar(context),
            buildProfilPhoto(50, 50, Profile(), context),
          ],
        )
      ],
    ),
  );
}

buildShopBoxCircleForAppBar(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(right: 8.0),
    child: Stack(
      children: [
        InkWell(
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => ShoppingCard())),
          child: Container(
            height: 50,
            width: 50,
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
        ),
        Positioned(
          top: 1,
          right: 4,
          child: Container(
            height: 15,
            width: 15,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Center(
                child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser?.uid)
                  .collection("singleProducts")
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  return Text(
                    "${snapshot.data.docs.length}",
                    style: TextStyle(fontSize: 9, color: Color(0xFFF56953)),
                  );
                }
              },
            )),
          ),
        )
      ],
    ),
  );
}
