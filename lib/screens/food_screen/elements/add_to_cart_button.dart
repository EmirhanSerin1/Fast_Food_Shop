import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_food_shop/models/shoping_cart.dart';
import 'package:fast_food_shop/screens/product_customize/customize.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../providers/quantity.dart';

class AddToCartButton extends StatelessWidget {
  AddToCartButton({
    Key? key,
    required this.foodName,
    required this.price,
    required this.imagePath,
  }) : super(key: key);

  final String foodName, price, imagePath;

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    final quant = Provider.of<Quantity>(context, listen: true);

    return InkWell(
      onTap: () {
        getDoc(user, quant);
        Navigator.of(context).push(_createRoute(this.foodName));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF56953),
        ),
        width: double.infinity,
        height: 45,
        child: Center(
            child: Container(
          padding: EdgeInsets.fromLTRB(4, 8, 4, 8),
          child: Text(
            "Add to cart",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        )),
      ),
    );
  }

  _sendOrderToFirestore(Quantity quant, docId, User? user) async {
    // calling firestore
    // calling product model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Cart cart = Cart();

    cart.idOfPerson = user!.uid;
    cart.productName = foodName;
    cart.productPrice = price;
    cart.imagePath = imagePath;
    cart.numberOfProduct = quant.quantity.toString();
    cart.totalProductPrice = (int.parse(price) * quant.quantity).toString();

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .collection("singleProducts")
        .doc(docId)
        .set(cart.toMap())
        .then(
            (value) => Fluttertoast.showToast(msg: "${cart.productName} added"))
        .then((value) => quant.deleteQuantity())
        .catchError((error) => Fluttertoast.showToast(msg: "stg went wrong"));
  }

// We can update our order with this method
  _upgradeOrder(
      String numberOfProduct, docId, User? user, Quantity quant) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    var doc = await firebaseFirestore
    .collection("users")
    .doc(user?.uid)
    .collection("singleProducts")
    .doc(docId)
    .get();

     var previusPrice = doc["totalProductPrice"];


    
    var totalProduct = int.parse(numberOfProduct) + quant.quantity;
    var totalProductPrice = int.parse(previusPrice) + (quant.quantity * int.parse(price));

    await firebaseFirestore
        .collection("users")
        .doc(user?.uid)
        .collection("singleProducts")
        .doc(docId)
        .update({
          "numberOfProduct": totalProduct.toString(),
          "totalProductPrice": totalProductPrice.toString()
        })
        .then((value) => Fluttertoast.showToast(msg: "${foodName} update"))
        .then((value) => quant.deleteQuantity())
        .catchError((error) =>
            Fluttertoast.showToast(msg: "sth went wrong while updating"));
  }

  getDoc(User? user, Quantity quant) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    var docRef = db
        .collection("users")
        .doc(user?.uid)
        .collection("singleProducts")
        .doc(foodName);

    await docRef.get().then((doc) => {
          if (doc.exists)
            {
              _upgradeOrder(doc["numberOfProduct"], foodName, user, quant),
            }
          else
            {
              // doc.data() will be undefined in this case
              _sendOrderToFirestore(quant, foodName, user),
            }
        });
  }

  Route _createRoute(String mainFoodName) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          Customize(mainFoodName: mainFoodName, mainFoodNamePrice: price),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
