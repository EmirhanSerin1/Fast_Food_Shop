import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_food_shop/screens/order_history/elements/order_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(user?.uid)
              .collection("orders")
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              return ListView.builder(
                itemCount: _getLength(snapshot),
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return OrderItem(
                    totalPrice: ds["totalPrice"],
                    orderDate: ds["orderDate"],
                    orders: ds["orders"],
                    address: ds["address"],
                    snapshot: snapshot,
                    index: index,
                    docs: snapshot.data.docs,
                  );
                },
              );
            }
          }),
    );
  }

  _getLength(AsyncSnapshot snapshot) {
    if (snapshot.data.docs.length == null) {
      return 0;
    } else {
      return snapshot.data.docs.length;
    }
  }
}
