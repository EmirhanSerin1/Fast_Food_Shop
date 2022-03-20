import 'package:fast_food_shop/screens/my_account/my_account.dart';
import 'package:fast_food_shop/screens/social_media_account/social_media_accounts.dart';
import 'package:fast_food_shop/screens/who_am_I/who_am_I.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../drawer/drawer.dart';
import '../shopping_cart/shopping_cart.dart';
import 'elements/appbar_custom.dart';
import 'elements/products_list.dart';
import 'elements/search_box.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  // TabController? tabController;

  @override
  void initState() {
    super.initState();
    // tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // final controller =
    //     Provider.of<SearchProvider>(context, listen: false).nameController;
    // if (controller.text.isEmpty) {
    //   FocusScope.of(context).unfocus();
    // }
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: Drawerr(),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              buildCustomAppbar(context),
              buildText("SEARCH FOR RECIPES", 26, FontWeight.w700),
              SizedBox(height: 20),
              SearchBox(),
              SizedBox(height: 20),
              buildText("Product List", 18, FontWeight.w500),
              SizedBox(height: 15),
              Productslist(),
              SizedBox(height: 10),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSpecialButtons(
                          context, Colors.red, "Shopping Cart", ShoppingCard()),
                      _buildSpecialButtons(
                          context, Colors.orange, "Who Am I", WhoAmI()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSpecialButtons(context, Colors.purple,
                          "Social Media Account", SocialMediaAccounts()),
                      _buildSpecialButtons(
                          context, Colors.green, "Profile", Profile()),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildSpecialButtons(
      BuildContext context, Color color, String text, Widget widget) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => widget)),
        child: Container(
          width: MediaQuery.of(context).size.width / 2.3,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: color,
            boxShadow: [
              BoxShadow(
                offset: const Offset(1, 3),
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 2,
              )
            ],
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding buildText(String text, double size, FontWeight weight) {
    return Padding(
      padding: EdgeInsets.only(left: 15),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: weight,
          fontSize: size,
          color: Color(0xFF1A1818),
        ),
      ),
    );
  }
}
