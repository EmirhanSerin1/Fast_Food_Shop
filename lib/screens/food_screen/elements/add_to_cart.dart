import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_food_shop/models/shooing_cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddToCard extends StatefulWidget {
  const AddToCard({
    Key? key,
    required this.price,
    required this.foodName,
    required this.imagePath,
  }) : super(key: key);
  final String price, foodName, imagePath;
  @override
  _AddToCardState createState() => _AddToCardState();
}

class _AddToCardState extends State<AddToCard> {
  var quantity = 1;

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            height: 70,
            width: 120,
            color: Colors.white,
            child: Center(
              child: Text(
                "\$" + (int.parse(widget.price) * quantity).toString(),
                style: TextStyle(
                  fontSize: 40,
                  color: Color(0xFF484A4E),
                  fontWeight: FontWeight.w500,
                ),
              ),
            )),
        buildAddToCart(user)
      ],
    );
  }

  buildAddToCart(User? user) {
    return Container(
      height: 60,
      width: 225,
      decoration: BoxDecoration(
          color: Color(0xFFF56953),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 40,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      addQuantity("REMOVE");
                    },
                    icon: Icon(
                      Icons.remove,
                      color: Color(0xFFF56953),
                    )),
                Text(
                  quantity.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFF56953),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      addQuantity("ADD");
                    },
                    icon: Icon(
                      Icons.add,
                      color: Color(0xFFF56953),
                    )),
              ],
            ),
          ),
          // StreamBuilder(
          //     stream: FirebaseFirestore.instance
          //         .collection("users")
          //         .doc(user?.uid)
          //         .collection("singleProducts")
          //         .snapshots(),
          //     builder: (BuildContext context, AsyncSnapshot snapshot) {
          //       return productAddMethod(user);
          //     })
          InkWell(
            onTap: () {
              //DocumentSnapshot<Map<String, dynamic>> doc = getDoc;

              _sendOrderToFirestore(quantity.toString(), widget.foodName, user);
            },
            child: Text(
              "Add to cart",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  addQuantity(pressed) {
    switch (pressed) {
      case "ADD":
        setState(() {
          quantity++;
        });
        return;
      case "REMOVE":
        if (quantity > 1) {
          setState(() {
            quantity -= 1;
          });
        }

        return;
    }
  }

  _sendOrderToFirestore(String quantity, docId, User? user) async {
    // calling firestore
    // calling product model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Cart cart = Cart();

    cart.idOfPerson = user!.uid;
    cart.productName = widget.foodName;
    cart.productPrice = widget.price;
    cart.imagePath = widget.imagePath;
    cart.numberOfProduct = quantity;
    cart.totalProductPrice =
        (int.parse(widget.price) * int.parse(quantity)).toString();

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .collection("singleProducts")
        .doc(docId)
        .set(cart.toMap())
        .then((value) =>
            Fluttertoast.showToast(msg: "${cart.productName} addeddd"))
        .catchError((error) => Fluttertoast.showToast(msg: "stg went wrong"));
  }

  _upgradeOrder(String numberOfProduct, docId, User? user, var quantity) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    var totalProduct = int.parse(numberOfProduct) + quantity;
    print(
        quantity.toString() + "......................................QUANTİTY");
    print(numberOfProduct +
        "......................................NUMBER OF PRODUCT");
    print(totalProduct.toString() +
        "......................................TOTAL PRODUCT");
    await firebaseFirestore
        .collection("user")
        .doc(user?.uid)
        .collection("singleProducts")
        .doc(docId)
        .update({"numberOfProduct": totalProduct.toString()})
        .then((value) =>
            Fluttertoast.showToast(msg: "${widget.foodName} addeddddddddddd"))
        .catchError((error) => Fluttertoast.showToast(msg: "stg went wrong"));
  }

  productAddMethod(User? user) async {
    var userDocRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection("singleProduct")
        .doc(widget.foodName)
        .get();
    var doc = await userDocRef;

    if (!doc.exists) {
      return InkWell(
        onTap: () {
          _upgradeOrder(
              doc["numberOfProduct"], widget.foodName, user, quantity);
        },
        child: Text(
          "Add to cart",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: () {
          _sendOrderToFirestore(quantity.toString(), widget.foodName, user);
        },
        child: Text(
          "Add to cart",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      );
    }
  }

  get getDoc async {
    User? user = _auth.currentUser;
    var userDocRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection("singleProduct")
        .doc(widget.foodName);

    var doc = await userDocRef.get();

    return doc;
  }
}
