import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_food_shop/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth extends ChangeNotifier {
  UserModel _user = UserModel();

  get user {
    return _user;
  }

  getUser() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    _user = UserModel(
      email: doc["email"],
      firstName: doc["firstName"],
      secondName: doc["secondName"],
      sex: doc["sex"],
      uid: doc["uid"],
    );
  }
}
