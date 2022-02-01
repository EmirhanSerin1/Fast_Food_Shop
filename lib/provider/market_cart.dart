import 'package:flutter/material.dart';

class ShopCart extends StatefulWidget {
  const ShopCart({Key key }) : super(key: key);

  @override
  _ShopCartState createState() => _ShopCartState();
}

class _ShopCartState extends State<ShopCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Shopping Cart", style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView(

        
      ),
      
    );
  }
}