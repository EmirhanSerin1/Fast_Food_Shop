import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_food_shop/screens/adress/deneme.dart';
import 'package:fast_food_shop/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Payment extends StatefulWidget {
  Payment({Key? key, required this.total}) : super(key: key);

  final String total;

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final cardNumberController = TextEditingController();
  final expiredDateController = TextEditingController();
  final cVVController = TextEditingController();
  final nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  List address = [];

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 18, left: 8, right: 8),
            child: Container(
              height: 100,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                color: Colors.grey.shade300,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: Offset(0, 3),
                    blurRadius: 3,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                        child: Text(
                          "Address",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.mode_edit_outline_outlined,
                        ),
                      ),
                    ],
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(user?.uid)
                        .collection("address")
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return SizedBox();
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return SizedBox();
                      } else {
                        List<QueryDocumentSnapshot> docAddress =
                            snapshot.data.docs;
                        address = docAddress.map((e) => e["address"]).toList();

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(address[0]),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 100.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreditCard(),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        bottomLeft: Radius.circular(16))),
                height: 50,
                width: double.infinity,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Go to Payment Page",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )

          // Container(
          //   height: MediaQuery.of(context).size.height / 3,
          //   padding: const EdgeInsets.all(8),
          //   width: double.infinity,
          //   color: Colors.white,
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Row(
          //         crossAxisAlignment: CrossAxisAlignment.end,
          //         children: [
          //          s Text(
          //             "Total: ",
          //             style: TextStyle(fontSize: 16),
          //           ),
          //           Text(
          //             widget.total + "\$",
          //             style: TextStyle(fontSize: 18),
          //           ),
          //         ],
          //       ),
          //       Row(
          //         children: [
          //           SizedBox(
          //             width: MediaQuery.of(context).size.width / 2.5,
          //           ),
          //           Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 "Products",
          //                 style: TextStyle(color: Colors.black),
          //               ),
          //               Container(
          //                 height: 60,
          //                 width: MediaQuery.of(context).size.width / 1.8,
          //                 color: Colors.grey.shade200,
          //                 child: ListView.builder(
          //                   itemCount: 5,
          //                   itemBuilder: (context, index) => getProducts(),
          //                 ),
          //               ),
          //               Text(
          //                 "Extras",
          //                 style: TextStyle(color: Colors.black),
          //               ),
          //               Container(
          //                 height: 60,
          //                 width: MediaQuery.of(context).size.width / 1.8,
          //                 color: Colors.grey.shade200,
          //                 child: ListView.builder(
          //                   itemCount: 5,
          //                   itemBuilder: (context, index) => getExtras(),
          //                 ),
          //               ),
          //             ],
          //           )
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Text getExtras() {
    return Text(
      "1x Cheese : 1\$",
      style: TextStyle(color: Colors.black54),
    );
  }

  Text getProducts() {
    return Text(
      "1x Cheeseburger : 32\$",
      style: TextStyle(color: Colors.black54),
    );
  }
}
