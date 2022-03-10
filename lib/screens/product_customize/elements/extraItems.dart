import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ExtraItems extends StatefulWidget {
  ExtraItems({
    Key? key,
    required this.foodName,
    required this.mainFoodName,
    required this.imagePath,
    required this.price,
  }) : super(key: key);
  final String imagePath;
  final String foodName;
  final String mainFoodName;

  final String price;
  @override
  State<ExtraItems> createState() => _ExtraItemsState();
}

class _ExtraItemsState extends State<ExtraItems> {
  Color buttonColor = Color(0xFFF56953);
  bool boolValue = false;
  String extrasButtonText = "Add";

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
      child: Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                offset: Offset(0, 3),
                blurRadius: 3,
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Color(0xFFFFE3DF),
                        ),
                        child: Center(
                          child: Image.network(
                            widget.imagePath,
                            height: 70,
                            width: 70,
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.foodName,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "\$" + widget.price,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFF68D7F),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: InkWell(
                onTap: () {
                  if (boolValue == false) {
                    _addExtra(user);
                    setState(() {
                      boolValue = !boolValue;
                      buttonColor = Colors.green.shade200;
                      extrasButtonText = "Added";
                    });
                  } else {
                    _deleteExtra(user);
                    setState(() {
                      boolValue = !boolValue;
                      buttonColor = Colors.red;
                      extrasButtonText = "Add";
                    });
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.circular(4)),
                  height: 20,
                  width: 60,
                  child: Center(
                    child: Text(
                      extrasButtonText,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _deleteExtra(User? user) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection("singleProducts")
        .doc(widget.mainFoodName)
        .get();

    Map extras = doc["extras"];

    var previusPrice = doc["totalProductPrice"];
    var totalPrice = int.parse(previusPrice) - int.parse(widget.price);

    extras.removeWhere((key, value) => key == widget.foodName);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection("singleProducts")
        .doc(widget.mainFoodName)
        .update({"extras": extras, "totalProductPrice": totalPrice.toString()});
  }

  Future<void> _addExtra(User? user) async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection("singleProducts")
        .doc(widget.mainFoodName)
        .get();

    var previusPrice = doc["totalProductPrice"];
    var totalPrice = int.parse(previusPrice) + int.parse(widget.price);

    Map extrass = doc["extras"];
    extrass[widget.foodName] = {
      "name": "${widget.foodName}",
      "price": "${widget.price}",
    };

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection("singleProducts")
        .doc(widget.mainFoodName)
        .update(
            {"extras": extrass, "totalProductPrice": totalPrice.toString()});
  }
}
