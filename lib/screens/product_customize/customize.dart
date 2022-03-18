import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_food_shop/screens/product_customize/elements/extraPart.dart';
import 'package:fast_food_shop/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/quantity.dart';

class Customize extends StatefulWidget {
  Customize(
      {Key? key, required this.mainFoodName, required this.mainFoodNamePrice})
      : super(key: key);

  final mainFoodName, mainFoodNamePrice;

  @override
  State<Customize> createState() => _CustomizeState();
}

class _CustomizeState extends State<Customize> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    final quant = Provider.of<Quantity>(context, listen: true);

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
                    buildDontWantMethod(user, quant, context),
                    buildAddedMethod(context),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  buildDontWantMethod(User? user, Quantity quant, BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: InkWell(
          onTap: () {
            _deleteExtras(user, quant);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MyHomePage()));
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
    );
  }

  buildAddedMethod(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: InkWell(
          onTap: (() {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MyHomePage()));
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
    );
  }

  Future<void> _deleteExtras(User? user, Quantity quant) async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection("singleProducts")
        .doc(widget.mainFoodName)
        .get();

    var numberOfProduct = doc["numberOfProduct"];

    var productPrice =
        int.parse(numberOfProduct) * int.parse(widget.mainFoodNamePrice);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection("singleProducts")
        .doc(widget.mainFoodName)
        .update(
      {
        "extras": {},
        "totalProductPrice": productPrice.toString(),
      },
    );
  }
}
