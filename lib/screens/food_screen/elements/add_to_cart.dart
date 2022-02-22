import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_food_shop/models/shooing_cart.dart';
import 'package:fast_food_shop/providers/set_doc_id.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

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
        buildAddToCart()
      ],
    );
  }

  buildAddToCart() {
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
          InkWell(
            onTap: () {
              sendOrderToFirestore(quantity.toString(),
                  Provider.of<DocId>(context, listen: false).docId.toString());
              Provider.of<DocId>(context, listen: false).increaseDocId();
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

  sendOrderToFirestore(String quantity, docId) async {
    // calling firestore
    // calling product model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
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
        .doc(docId.toString())
        .set(cart.toMap())
        .then(
            (value) => Fluttertoast.showToast(msg: "${cart.productName} added"))
        .catchError((error) => Fluttertoast.showToast(msg: "stg went wrong"));
  }
}
