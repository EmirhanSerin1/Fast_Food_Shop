import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_food_shop/screens/shopping_cart/shopping_cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppBarForSelected extends StatelessWidget {
  AppBarForSelected({
    Key? key,

  }) : super(key: key);


  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;

    return Padding(
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            splashRadius: 30,
            splashColor: Color(0xFFF56953).withOpacity(0.2),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.black),
          ),
          Stack(
            children: [
              InkWell(
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> ShoppingCard())),
                child: Container(
                  height: 40,
                  width: 40,
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
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                      child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc(user?.uid)
                        .collection("singleProducts")
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else {
                        return Text(
                          "${snapshot.data.docs.length}",
                          style:
                              TextStyle(fontSize: 9, color: Color(0xFFF56953)),
                        );
                      }
                    },
                  )),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
