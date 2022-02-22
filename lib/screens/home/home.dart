import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_food_shop/core/foodTabs/cheapest_tabs.dart';
import 'package:fast_food_shop/core/foodTabs/favorites_tabs.dart';
import 'package:fast_food_shop/core/foodTabs/food_tabs.dart';
import 'package:fast_food_shop/core/foodTabs/recommended_tabs.dart';
import 'package:fast_food_shop/screens/drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'elements/appbar_custom.dart';
import 'elements/products.dart';
import 'elements/search_box.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        drawer: Drawerr(),
        body: ListView(
          children: [
            buildCustomAppbar(context),
            buildText("SEARCH FOR", 26, FontWeight.w700),
            buildText("RECIPES", 26, FontWeight.w700),
            SizedBox(height: 20),
            buildSearchBox(),
            SizedBox(height: 20),
            buildText("Product List", 18, FontWeight.w500),
            SizedBox(height: 15),
            products(),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: TabBar(
                controller: tabController,
                isScrollable: true,
                indicatorColor: Colors.transparent,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey.withOpacity(0.5),
                labelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle:
                    TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                tabs: [
                  Tab(child: Text("FEATURED")),
                  Tab(child: Text("CHEAPEST")),
                  Tab(child: Text("FAVORITES")),
                  Tab(child: Text("RECOMMENDED")),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 450,
              child: TabBarView(
                controller: tabController,
                children: [
                  FoodTab(),
                  CheapestTabs(),
                  FavoritesTabs(),
                  RecommendedTabs(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container products() {
    return Container(
      height: 200,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            Fluttertoast.showToast(msg: "loading");
            return SizedBox();
          } else {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                 return ProductList(
                  foodName: ds["name"], 
                  imagePath: ds["image"],
                  price: ds["price"], 
                  color: Color(0xFFB2F5C8),
                  textColor: Color(0xFF649451),
                  );
              },
            );
          }
        },
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
