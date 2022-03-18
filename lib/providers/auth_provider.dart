import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_food_shop/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Auth extends ChangeNotifier {
  UserModel _user = UserModel();

  get user {
    return _user;
  }

  getUser() async {
    print("ok");
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    print(doc["email"]);
    _user = UserModel(
      email: doc["email"],
      firstName: doc["firstName"],
      secondName: doc["secondName"],
      sex: doc["sex"],
      uid: doc["uid"],
    );
  }
}
