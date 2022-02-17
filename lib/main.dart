import 'package:fast_food_shop/models/Cart/provider/cart_provider.dart';
import 'package:fast_food_shop/screens/authentication/login/login_screen.dart';
import 'package:fast_food_shop/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: Builder(builder: (BuildContext context){
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Fast_Food_Shop',
        theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
      }),);
  }
}
