import 'dart:async';

import 'package:fast_food_shop/screens/my_account/my_account.dart';
import 'package:fast_food_shop/screens/order_history/order_history.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/profiile_photo/profil_photo.dart';
import '../../models/user.dart';
import '../authentication/login/login_screen.dart';
import '../shopping_cart/shopping_cart.dart';
import '../settings/settings.dart';

class Drawerr extends StatefulWidget {
  @override
  State<Drawerr> createState() => _DrawerrState();
}

class _DrawerrState extends State<Drawerr> {
  var padding = const EdgeInsets.symmetric(horizontal: 20);

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  // full name will come after delay
  // late Timer _timer;
  // Widget fullName = CircularProgressIndicator(strokeWidth: 1);
  // Widget email = CircularProgressIndicator(strokeWidth: 1);

  // _DrawerrState() {
  //   _timer = new Timer(const Duration(milliseconds: 800), () {
  //     setState(() {
  //       fullName = fullNameAfterDelay;
  //       email = emailAfterDelay;
  //     });
  //   });
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _timer.cancel();
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(user!.uid)
  //       .get()
  //       .then((value) {
  //     this.loggedInUser = UserModel.fromMap(value.data());
  //     setState(() {});
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Drawer(
        child: SafeArea(
          child: ListView(
            children: [
              Column(
                children: [
                  buildTop(context),
                  buildMenuItem(
                      "My Account", Icons.account_circle, Profile(), context),
                  buildMenuItem("Shopping Cart", Icons.shopping_cart_outlined,
                      ShoppingCard(), context),
                  buildMenuItem("Order History", Icons.shopping_cart_outlined,
                      OrderHistory(), context),
                  Divider(),
                  buildMenuItem(
                      "Settings", Icons.settings, Settings(), context),
                  buildLogOutButton(),
                ],
              ),
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
                  child: BuildProfilPhoto(75, 75, Profile()),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    fullName,
                    email,
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color.fromARGB(255, 243, 238, 238),
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                color: Colors.red.withOpacity(0.3),
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
                  onPressed: () {
                    showAlertdialog();
                    // logout(context);
                  },
                  icon: Icon(
                    Icons.power_settings_new,
                    color: Colors.red,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  showAlertdialog() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Logout'),
        content:
            const Text('Are you sure you want to sign out of your account?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => logout(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut().then((value) =>
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen())));
  }

  get fullName => SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Text(
          FirebaseAuth.instance.currentUser?.displayName ?? "",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      );

  get email => SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Text(
          FirebaseAuth.instance.currentUser?.email ?? "no email",
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
      );
}
