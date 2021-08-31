import 'package:flutter/material.dart';

class Drawerr extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          children: [
            buildTop(),
            //SizedBox(height: 50),
            buildMenuItem("My Account", Icons.account_circle),
            buildMenuItem("My Orders", Icons.inventory_outlined),
            buildMenuItem("Shopping Cart", Icons.shopping_cart_outlined),
            buildMenuItem("My Favorites", Icons.favorite_border_outlined),
            buildMenuItem("Messages", Icons.mail),
            Divider(),
            buildMenuItem("Settings", Icons.settings),
          ],
        ),
      ),
    );
  }

  buildTop() {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 75,
                    width: 75,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFDBF0FF),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5,
                          spreadRadius: 3,
                          color: Colors.grey.withOpacity(0.5),
                          offset: Offset(0, 3),
                        )
                      ],
                      image: DecorationImage(
                        image: AssetImage("assets/user/person.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
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

  buildMenuItem(String text, IconData icon) {
    final color = Color(0xFFF3F3F3);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
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
