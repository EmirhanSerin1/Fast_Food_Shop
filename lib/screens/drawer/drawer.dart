import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_food_shop/core/profiile_photo/profil_photo.dart';
import 'package:fast_food_shop/models/user.dart';
import 'package:fast_food_shop/screens/authentication/login/login_screen.dart';
import 'package:fast_food_shop/screens/drawer/screensInDrawer/my_account/my_account.dart';
import 'package:fast_food_shop/screens/drawer/screensInDrawer/my_orders.dart';
import 'package:fast_food_shop/screens/drawer/screensInDrawer/shopping_cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Drawerr extends StatefulWidget {
  @override
  State<Drawerr> createState() => _DrawerrState();
}

class _DrawerrState extends State<Drawerr> {
  var padding = const EdgeInsets.symmetric(horizontal: 20);

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  buildTop(context),
                  //SizedBox(height: 50),
                  buildMenuItem(
                      "My Account", Icons.account_circle, Profile(), context),
                  buildMenuItem(
                      "My Orders", Icons.inventory_outlined, MyOrders(), context),
                  buildMenuItem("Shopping Cart", Icons.shopping_cart_outlined,
                      ShoppingCard(), context),
                  //buildMenuItem("Messages", Icons.mail, Messages(), context),
                  Divider(),
                  //buildMenuItem("Settings", Icons.settings),
                ],
              ),
              buildLogOutButton(),
            ],
          ),
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
                      "${loggedInUser.firstName} ${loggedInUser.secondName}",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "${loggedInUser.email}",
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

  buildMenuItem(
      String text, IconData icon, Widget widget, BuildContext context) {
    final color = Color(0xFFF3F3F3);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => widget));
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(8, 12, 8, 12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0xFFDA4646),
              boxShadow: [
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

  buildLogOutButton() {
    return InkWell(
      onTap: () {
        logout(context);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color.fromARGB(255, 243, 238, 238),
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                color: Colors.black.withOpacity(0.3),
                offset: Offset(3, 3),
              )
            ]),
        height: 50,
        width: double.infinity,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Log Out"),
              ),
              IconButton(
                  onPressed: () {}, icon: Icon(Icons.power_settings_new, color: Colors.red,)),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
