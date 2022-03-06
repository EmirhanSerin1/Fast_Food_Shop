import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_food_shop/providers/quantity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductQuantity extends StatefulWidget {
  const ProductQuantity({Key? key, required this.price, required this.foodName})
      : super(key: key);
  final String price;
  final String foodName;
  @override
  _ProductQuantityState createState() => _ProductQuantityState();
}

class _ProductQuantityState extends State<ProductQuantity> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    final quant = Provider.of<Quantity>(context, listen: true);
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 70,
            width: 120,
            color: Colors.white,
            child: Center(
              child: Text(
                "\$" + (int.parse(widget.price) * quant.quantity).toString(),
                style: TextStyle(
                  fontSize: 40,
                  color: Color(0xFF484A4E),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          quantityOfProduct(user, quant)
        ],
      ),
    );
  }

  quantityOfProduct(User? user, Quantity quant) {
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
            width: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      quant.decreaseQuantity();
                    },
                    icon: Icon(
                      Icons.remove,
                      color: Color(0xFFF56953),
                    )),
                Text(
                  // quantity.toString(),
                  quant.quantity.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFFF56953),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      quant.increaseQuantity();
                    },
                    icon: Icon(
                      Icons.add,
                      color: Color(0xFFF56953),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _getDocData(User? user, Quantity quant) async {

    FirebaseFirestore db = FirebaseFirestore.instance;
    var docRef = db
        .collection("users")
        .doc(user?.uid)
        .collection("singleProducts")
        .doc(widget.foodName)
        .collection("extras")
        .doc();

  }
}
