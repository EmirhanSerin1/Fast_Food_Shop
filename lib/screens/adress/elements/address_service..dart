import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_food_shop/models/address_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

sendAddresstoFirestore(
    User? user,
    AddressModel addressModel,
    TextEditingController countryController,
    TextEditingController cityController,
    TextEditingController districtController,
    TextEditingController streetController,
    TextEditingController buildingNumberController,
    TextEditingController flatNumberController,
    TextEditingController otherController) async {
  //Calling Firebase
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //Adding values to Cart
  addressModel = AddressModel(
    country: countryController.text,
    city: cityController.text,
    district: districtController.text,
    street: streetController.text,
    buildingNumber: buildingNumberController.text,
    flatNumber: flatNumberController.text,
    other: otherController.text,
  );

  await firebaseFirestore
      .collection("users")
      .doc(user?.uid)
      .collection("address")
      .doc("address")
      .set(addressModel.toMap())
      .then((value) => Fluttertoast.showToast(msg: "Address Added"))
      .then((value) => controllerClear(
          countryController,
          cityController,
          districtController,
          streetController,
          buildingNumberController,
          flatNumberController,
          otherController));
}

upgradeAddress(
    User? user,
    AddressModel addressModel,
    TextEditingController countryController,
    TextEditingController cityController,
    TextEditingController districtController,
    TextEditingController streetController,
    TextEditingController buildingNumberController,
    TextEditingController flatNumberController,
    TextEditingController otherController) async {
  //Calling Firebase
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

 
    await firebaseFirestore
        .collection("users")
        .doc(user?.uid)
        .collection("address")
        .doc("address")
        .update({
          "countryController": countryController,
          "cityController": cityController,
          "districtController": districtController,
          "streetController": streetController,
          "buildingNumberController": buildingNumberController,
          "flatNumberController": flatNumberController,
          "otherController": otherController,
        })
        .then((value) => Fluttertoast.showToast(msg: "Address Updated"))
        .then((value) => controllerClear(
            countryController,
            cityController,
            districtController,
            streetController,
            buildingNumberController,
            flatNumberController,
            otherController));
  
}

buildEmptyAddress() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Country :  ", style: TextStyle(fontStyle: FontStyle.italic)),
        Text("City :  ", style: TextStyle(fontStyle: FontStyle.italic)),
        Text("District :  ", style: TextStyle(fontStyle: FontStyle.italic)),
        Text("Street :  ", style: TextStyle(fontStyle: FontStyle.italic)),
        Text("BuildingNumber :  ",
            style: TextStyle(fontStyle: FontStyle.italic)),
        Text("FlatNumber :  ", style: TextStyle(fontStyle: FontStyle.italic)),
        Text("Other :  ", style: TextStyle(fontStyle: FontStyle.italic)),
      ],
    ),
  );
}

Padding buildAddress(
  String country,
  String city,
  String district,
  String street,
  String buildingNumber,
  String flatNumber,
  String other,
) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Country :  " + country,
            style: TextStyle(fontStyle: FontStyle.italic)),
        Text("City :  " + city, style: TextStyle(fontStyle: FontStyle.italic)),
        Text("District :  " + district,
            style: TextStyle(fontStyle: FontStyle.italic)),
        Text("Street :  " + street,
            style: TextStyle(fontStyle: FontStyle.italic)),
        Text("BuildingNumber :  " + buildingNumber,
            style: TextStyle(fontStyle: FontStyle.italic)),
        Text("FlatNumber :  " + flatNumber,
            style: TextStyle(fontStyle: FontStyle.italic)),
        Text("Other :  " + other,
            style: TextStyle(fontStyle: FontStyle.italic)),
      ],
    ),
  );
}

controllerClear(
    TextEditingController countryController,
    TextEditingController cityController,
    TextEditingController districtController,
    TextEditingController streetController,
    TextEditingController buildingNumberController,
    TextEditingController flatNumberController,
    TextEditingController otherController) {
  countryController.clear();
  cityController.clear();
  districtController.clear();
  streetController.clear();
  buildingNumberController.clear();
  flatNumberController.clear();
  otherController.clear();
}
