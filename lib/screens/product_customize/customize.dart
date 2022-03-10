import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_food_shop/screens/product_customize/elements/extraPart.dart';
import 'package:fast_food_shop/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Customize extends StatefulWidget {
  Customize({Key? key, required this.mainFoodName }) : super(key: key);

  final mainFoodName;

  @override
  State<Customize> createState() => _CustomizeState();
}

class _CustomizeState extends State<Customize> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                flex: 9, child: ExtraPart(mainFoodName: widget.mainFoodName)),
            Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: InkWell(
                          onTap: () {
                            _deleteExtras(user);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyHomePage()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 3),
                                      color: Colors.grey.withOpacity(0.3),
                                      blurRadius: 3)
                                ]),
                            child: Center(
                              child: Text("I don't want"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: InkWell(
                          onTap: (() {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyHomePage()));
                          }),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 3),
                                      color: Colors.grey.withOpacity(0.3),
                                      blurRadius: 3)
                                ]),
                            child: Center(
                              child: Text("Ok I Added"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Future<void> _deleteExtras(User? user) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection("singleProducts")
        .doc(widget.mainFoodName)
        .update({"extras": {}});
  }
}
