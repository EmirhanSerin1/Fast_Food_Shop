import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_food_shop/screens/payment/payment.dart';
import 'package:fast_food_shop/screens/shopping_cart/elements/cart_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ShoppingCard extends StatefulWidget {
  ShoppingCard({Key? key}) : super(key: key);

  @override
  State<ShoppingCard> createState() => _ShoppingCardState();
}

class _ShoppingCardState extends State<ShoppingCard> {
  final _auth = FirebaseAuth.instance;
  List productsPrice = [];
  int total = 0;

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
            .collection("singleProducts")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox();
          } else {
            List<QueryDocumentSnapshot> docsForProductPrice = snapshot.data.docs;
             productsPrice = docsForProductPrice.map((e) => e["totalProductPrice"]).toList();
            return Column(
              children: [
                Expanded(
                  flex: 90,
                  child: ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot ds = snapshot.data.docs[index];
                      List<QueryDocumentSnapshot> docss = snapshot.data.docs;

                      return CartItem(
                        index: index,
                        docss: docss,
                        snapshot: snapshot,
                        foodName: ds["productName"],
                        imagePath: ds["imagePath"],
                        price: ds["productPrice"],
                        numberOfProduct: ds["numberOfProduct"],
                        user: user,
                      );
                    },
                  ),
                ),
                Expanded(
                    flex: 11,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(1, 3),
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                )
                              ],
                            ),
                            height: 40,
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: Row(
                              children: [
                                Text("  Total:   "),
                                Text(
                                  _getPrice().toString() + "\$",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Payment())),
                            child: Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width / 2,
                              padding: const EdgeInsets.fromLTRB(8, 4, 4, 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.red,
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(1, 3),
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                  )
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Go to payment Page",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ))
              ],
            );
          }
        },
      ),
    );
  }

  _getPrice()  {
    
    if (productsPrice.isNotEmpty) {
       return productsPrice.reduce(
        (value, element) {
          var sum = int.parse(value) + int.parse(element);
          return sum.toString();
        },
      );
      
    } else {
      return "0";
    }
  }
}
