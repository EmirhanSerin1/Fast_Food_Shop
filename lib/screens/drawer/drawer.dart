
import 'package:fast_food_shop/core/profiile_photo/profil_photo.dart';
import 'package:fast_food_shop/screens/drawer/screensInDrawer/messages.dart';
import 'package:fast_food_shop/screens/drawer/screensInDrawer/my_account/my_account.dart';
import 'package:fast_food_shop/screens/drawer/screensInDrawer/my_favorites.dart';
import 'package:fast_food_shop/screens/drawer/screensInDrawer/my_orders.dart';
import 'package:fast_food_shop/screens/drawer/screensInDrawer/shopping_cart.dart';
import 'package:flutter/material.dart';

class Drawerr extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          children: [
            buildTop(context),
            //SizedBox(height: 50),
            buildMenuItem("My Account", Icons.account_circle, Profile(), context),
            buildMenuItem("My Orders", Icons.inventory_outlined, MyOrders(), context ),
            buildMenuItem("Shopping Cart", Icons.shopping_cart_outlined, ShoppingCard(), context),
            buildMenuItem("My Favorites", Icons.favorite_border_outlined, Favorites(), context),
            buildMenuItem("Messages", Icons.mail, Messages(), context),
            Divider(),
            //buildMenuItem("Settings", Icons.settings),
          ],
        ),
      ),
    );
  }

  buildTop(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: buildProfilPhoto(75, 75, Profile(), context),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Christina Pristine",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "christinapristine@gmail.com",
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }

  buildMenuItem(String text, IconData icon, Widget widget, BuildContext context) {
    final color = Color(0xFFF3F3F3);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(8, 12, 8, 12),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Color(0xFFDA4646), boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: Colors.black.withOpacity(0.3),
              offset: Offset(3, 3),
            )
          ]),
          child: Row(
            children: [
              Icon(
                icon,
                color: Color(0xFFF3F3F3),
              ),
              SizedBox(width: 10),
              Text(
                text,
                style: TextStyle(color: color, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
