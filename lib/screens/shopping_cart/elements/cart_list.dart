import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartItem extends StatefulWidget {
  CartItem({
    Key? key,
    required this.foodName,
    required this.imagePath,
    required this.price,
    required this.numberOfProduct,
    required this.user,
    required this.docss,
    required this.snapshot,
    required this.index,
  }) : super(key: key);

  final String foodName, imagePath, price, numberOfProduct;
  final User? user;
  final int index;

  final AsyncSnapshot snapshot;
  final List<QueryDocumentSnapshot> docss;

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int quantity = 0;
  final _auth = FirebaseAuth.instance;

  List productsPrice = [];
  List extrasPrice = [];

  @override
  Widget build(BuildContext context) {
    getExtrasPrice(widget.snapshot, widget.docss, widget.index);
    var totalPrice =
        int.parse(widget.price) * int.parse(widget.numberOfProduct);
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onLongPress: () {
                      getExtraList(widget.snapshot, widget.docss, widget.index);
                      _showAlertdialog(widget.snapshot);
                    },
                    child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: CachedNetworkImage(
                          imageUrl: widget.imagePath,
                          height: 70,
                          width: 70,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 0, 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
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
                                  if (quantity > 1) {
                                    quantity--;
                                    var totalPrice =
                                        quantity * int.parse(widget.price);
                                    _decreaseNumberOfProject(
                                        widget.foodName, quantity);
                                    _upgradeTotalPrice(
                                        widget.foodName, totalPrice);
                                  }
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
                                  _increaseNumberOfProject(
                                      widget.foodName, quantity);
                                  _upgradeTotalPrice(
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${totalPrice + total}" + "\$ ",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "(" +
                            totalPrice.toString() +
                            "+" +
                            total.toString() +
                            ")",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(width: 15),
                  IconButton(
                    onPressed: () {
                      _deleteProduct(widget.foodName, widget.user);
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

  _showAlertdialog(AsyncSnapshot snapshot) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Extras'),
        content: Container(
          height: 75,
          child: ListView.builder(
            itemCount: listOfExtrasLenght,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(listOfExtras[index]["name"] +
                    " : " +
                    listOfExtras[index]["price"] +
                    "\$"),
              );
            },
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteProduct(var docId, User? user) {
    CollectionReference product = FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection("singleProducts");

    return product
        .doc(docId)
        .delete()
        .catchError((error) => Fluttertoast.showToast(msg: error.toString()));
  }

  Future<void> _increaseNumberOfProject(var docId, quantity) {
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

  Future<void> _decreaseNumberOfProject(var docId, quantity) async {
    User? user = _auth.currentUser;
    CollectionReference product = FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection("singleProducts");

    return await product
        .doc(docId)
        .update({"numberOfProduct": quantity.toString()}).catchError(
            (error) => Fluttertoast.showToast(msg: "Something Went Wrong "));
  }

  Future<void> _upgradeTotalPrice(var docId, totalPrice) {
    User? user = _auth.currentUser;
    CollectionReference product = FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection("singleProducts");

    var upgradedPrice = totalPrice + total;

    return product
        .doc(docId)
        .update({"totalProductPrice": upgradedPrice.toString()}).catchError(
            (error) => Fluttertoast.showToast(msg: "Something Went Wrong "));
  }

  int getExtrasPrice(
      AsyncSnapshot snapshot, List<QueryDocumentSnapshot> docss, int index) {
    var total = 0;
    dynamic extras = docss.map((e) => e["extras"]).toList();
    List extrass = extras[index].values.toList();

    for (var i in extrass) {
      total += int.parse(i["price"]);
    }

    return total;
  }

  get total => getExtrasPrice(widget.snapshot, widget.docss, widget.index);

  List getExtraList(
      AsyncSnapshot snapshot, List<QueryDocumentSnapshot> docss, int index) {
    dynamic extras = docss.map((e) => e["extras"]).toList();
    List extrass = extras[index].values.toList();
    print(extrass[0]["name"]);
    return extrass;
  }

  get listOfExtras => getExtraList(widget.snapshot, widget.docss, widget.index);
  int get listOfExtrasLenght =>
      getExtraList(widget.snapshot, widget.docss, widget.index).length;
}
