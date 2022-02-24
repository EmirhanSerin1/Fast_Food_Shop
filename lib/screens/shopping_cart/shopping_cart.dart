import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_food_shop/screens/shopping_cart/elements/cart_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ShoppingCard extends StatefulWidget {
  ShoppingCard({Key? key}) : super(key: key);

  @override
  State<ShoppingCard> createState() => _ShoppingCardState();
}

class _ShoppingCardState extends State<ShoppingCard> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
            .collection("singleProducts")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox();
          } else {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                return CartItem(
                  foodName: ds["productName"],
                  imagePath: ds["imagePath"],
                  price: ds["productPrice"],
                  numberOfProduct: ds["numberOfProduct"],
                  user: user,
                );
              },
            );
          }
        },
      ),
    );
  }
}
