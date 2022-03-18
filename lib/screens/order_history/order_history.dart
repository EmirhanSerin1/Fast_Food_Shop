import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_food_shop/models/user.dart';
import 'package:fast_food_shop/providers/auth_provider.dart';
import 'package:fast_food_shop/screens/order_history/elements/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<Auth>(context, listen: false).user;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(user.uid)
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
                    );
                  });
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
