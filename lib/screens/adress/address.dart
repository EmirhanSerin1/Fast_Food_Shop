import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_food_shop/models/address_model.dart';
import 'package:fast_food_shop/providers/address_formKey.dart';
import 'package:fast_food_shop/screens/adress/adress_edit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../payment/payment.dart';

class Address extends StatefulWidget {
  Address({Key? key, required this.total}) : super(key: key);

  final String total;

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  final _auth = FirebaseAuth.instance;

  List address = [];
  AddressModel addressModel = AddressModel();
  @override
  Widget build(BuildContext context) {
    final formKey =
        Provider.of<AddressTextField>(context, listen: false).formKey;
    final cityController =
        Provider.of<AddressTextField>(context, listen: false).cityController;
    final countryController =
        Provider.of<AddressTextField>(context, listen: false).countryController;
    final streetController =
        Provider.of<AddressTextField>(context, listen: false).streetController;
    final districtController =
        Provider.of<AddressTextField>(context, listen: false)
            .districtController;
    final buildingNumberController =
        Provider.of<AddressTextField>(context, listen: false)
            .buildingNumberController;
    final flatNumberController =
        Provider.of<AddressTextField>(context, listen: false)
            .flatNumberController;
    final otherController =
        Provider.of<AddressTextField>(context, listen: false).otherController;
    User? user = _auth.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 90,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 18, left: 8, right: 8),
                  child: Container(
                    height: 150,
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
                          ],
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .doc(user?.uid)
                              .collection("address")
                              .snapshots(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return SizedBox();
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return SizedBox();
                            } else {
                              DocumentSnapshot ds = snapshot.data.docs[0];

                              return buildAddress(
                                ds["country"],
                                ds["city"],
                                ds["district"],
                                ds["street"],
                                ds["buildingNumber"],
                                ds["flatNumber"],
                                ds["other"],
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                AddressEdit()
              ],
            ),
          ),
          Expanded(
            flex: 20,
            child: Container(
              width: double.infinity,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 0,
                    width: 0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 2),
                          child: InkWell(
                            onTap: () {
                              getDoc(
                                  user,
                                  countryController.text,
                                  cityController.text,
                                  districtController.text,
                                  streetController.text,
                                  buildingNumberController.text,
                                  flatNumberController.text,
                                  otherController.text);
                              controllerClear(
                                  countryController,
                                  cityController,
                                  districtController,
                                  streetController,
                                  buildingNumberController,
                                  flatNumberController,
                                  otherController);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(16),
                                    bottomRight: Radius.circular(16)),
                              ),
                              height: 45,
                              width: double.infinity,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Add New Address",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      ),
                                    ),
                                    Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 2.0),
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
                                    bottomLeft: Radius.circular(16)),
                              ),
                              height: 45,
                              width: double.infinity,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Go to Payment Page",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14),
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
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
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
          Text("Country :  "+country),
          Text("City :  "+city),
          Text("District :  "+district),
          Text("Street :  "+street),
          Text("BuildingNumber :  "+buildingNumber),
          Text("FlatNumber :  "+flatNumber),
          Text("Other :  "+other),
        ],
      ),
    );
  }

  sendAddresstoFirestore(
      User? user,
      AddressModel addressModel,
      String countryController,
      String cityController,
      String districtController,
      String streetController,
      String buildingNumberController,
      String flatNumberController,
      String otherController) async {
    //Calling Firebase
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    //Adding values to Cart
    addressModel = AddressModel(
      country: countryController,
      city: cityController,
      district: districtController,
      street: streetController,
      buildingNumber: buildingNumberController,
      flatNumber: flatNumberController,
      other: otherController,
    );

    await firebaseFirestore
        .collection("users")
        .doc(user?.uid)
        .collection("address")
        .doc("address")
        .set(addressModel.toMap())
        .then((value) => Fluttertoast.showToast(msg: "Address Added"));
  }

  upgradeAddress(
      User? user,
      AddressModel addressModel,
      String countryController,
      String cityController,
      String districtController,
      String streetController,
      String buildingNumberController,
      String flatNumberController,
      String otherController) async {
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
    }).then((value) => Fluttertoast.showToast(msg: "Address Updated"));
  }

  getDoc(
      User? user,
      String countryController,
      String cityController,
      String districtController,
      String streetController,
      String buildingNumberController,
      String flatNumberController,
      String otherController) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    var docRef = db
        .collection("users")
        .doc(user?.uid)
        .collection("address")
        .doc("address");

    await docRef.get().then((doc) => {
          if (doc.exists)
            {
              sendAddresstoFirestore(
                  user,
                  addressModel,
                  countryController,
                  cityController,
                  districtController,
                  streetController,
                  buildingNumberController,
                  flatNumberController,
                  otherController)
            }
          else
            {
              upgradeAddress(
                  user,
                  addressModel,
                  countryController,
                  cityController,
                  districtController,
                  streetController,
                  buildingNumberController,
                  flatNumberController,
                  otherController)
            }
        });
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
}
