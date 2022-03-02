import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartItem extends StatefulWidget {
  const CartItem({
    Key? key,
    required this.foodName,
    required this.imagePath,
    required this.price,
    required this.numberOfProduct,
    required this.user,
  }) : super(key: key);

  final String foodName, imagePath, price, numberOfProduct;
  final User? user;

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int quantity = 0;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var totalPrice =
        int.parse(widget.price) * int.parse(widget.numberOfProduct);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(1, 3),
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 2,
                )
              ]),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.imagePath),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 0, 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          widget.foodName,
                          style: TextStyle(fontSize: 18),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: IconButton(
                                icon: Icon(Icons.arrow_back_ios),
                                onPressed: () {
                                  quantity = int.parse(widget.numberOfProduct);
                                  quantity--;
                                  var totalPrice =
                                      quantity * int.parse(widget.price);
                                  decreaseNumberOfProject(
                                      widget.foodName, quantity);
                                  upgradeTotalPrice(
                                      widget.foodName, totalPrice);
                                },
                              ),
                            ),
                            Text(
                              widget.numberOfProduct,
                              style: TextStyle(fontSize: 16),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                              child: IconButton(
                                icon: Icon(Icons.arrow_forward_ios),
                                onPressed: () {
                                  quantity = int.parse(widget.numberOfProduct);
                                  quantity++;
                                  var totalPrice =
                                      quantity * int.parse(widget.price);
                                  increaseNumberOfProject(
                                      widget.foodName, quantity);
                                  upgradeTotalPrice(
                                      widget.foodName, totalPrice);
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    totalPrice.toString() + "\$ ",
                    style: TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    onPressed: () {
                      deleteProduct(widget.foodName, widget.user);
                    },
                    icon: Icon(Icons.delete_outline),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> deleteProduct(var docId, User? user) {
    CollectionReference product = FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection("singleProducts");

    return product
        .doc(docId)
        .delete()
        .catchError((error) => Fluttertoast.showToast(msg: error.toString()));
  }

  Future<void> increaseNumberOfProject(var docId, quantity) {
    User? user = _auth.currentUser;
    CollectionReference product = FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection("singleProducts");

    return product
        .doc(docId)
        .update({"numberOfProduct": quantity.toString()}).catchError(
            (error) => Fluttertoast.showToast(msg: "Something Went Wrong "));
  }

  Future<void> decreaseNumberOfProject(var docId, quantity) {
    User? user = _auth.currentUser;
    CollectionReference product = FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection("singleProducts");

    return product
        .doc(docId)
        .update({"numberOfProduct": quantity.toString()}).catchError(
            (error) => Fluttertoast.showToast(msg: "Something Went Wrong "));
  }

  Future<void> upgradeTotalPrice(var docId, totalPrice) {
    User? user = _auth.currentUser;
    CollectionReference product = FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection("singleProducts");

    return product
        .doc(docId)
        .update({"totalProductPrice": totalPrice.toString()}).catchError(
            (error) => Fluttertoast.showToast(msg: "Something Went Wrong "));
  }
}
