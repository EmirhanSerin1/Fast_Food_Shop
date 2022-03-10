import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'extraItems.dart';

class ExtraPart extends StatelessWidget {
  ExtraPart({Key? key, required this.mainFoodName}) : super(key: key);

  final String mainFoodName;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('extras').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            Fluttertoast.showToast(msg: "loading");
            return SizedBox();
          } else {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                return ExtraItems(
                  
                    imagePath: ds["imagePath"],
                    mainFoodName: mainFoodName,
                    foodName: ds["name"],
                    price: ds["price"]);
              },
            );
          }
        },
      ),
    );
  }
}
