import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_food_shop/models/address_model.dart';
import 'package:fast_food_shop/providers/address_edit_provider.dart';
import 'package:fast_food_shop/providers/address_check_provider.dart';
import 'package:fast_food_shop/screens/adress/elements/adress_edit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'elements/address_service..dart';

class AddressProfile extends StatefulWidget {
  AddressProfile({Key? key}) : super(key: key);


  @override
  State<AddressProfile> createState() => _AddressProfileState();
}

class _AddressProfileState extends State<AddressProfile> {
  final _auth = FirebaseAuth.instance;

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
    //for check
    List<QueryDocumentSnapshot> docss =
        Provider.of<AddressCheck>(context, listen: false).doc;
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
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.2),
                          offset: Offset(0, 3),
                          blurRadius: 3,
                        )
                      ],
                    ),
                    child: ListView(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
                              child: Text(
                                "Address",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
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
                              return CircularProgressIndicator();
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return SizedBox();
                            } else {
                              docss = snapshot.data.docs;
                              if (docss.isNotEmpty) {
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
                              } else {
                                return buildEmptyAddress();
                              }
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
                      // Add New Address button
                      addNewAddress(
                          formKey,
                          user,
                          countryController,
                          cityController,
                          districtController,
                          streetController,
                          buildingNumberController,
                          flatNumberController,
                          otherController,
                          docss),
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


  Expanded addNewAddress(
      GlobalKey<FormState> formKey,
      User? user,
      TextEditingController countryController,
      TextEditingController cityController,
      TextEditingController districtController,
      TextEditingController streetController,
      TextEditingController buildingNumberController,
      TextEditingController flatNumberController,
      TextEditingController otherController,
      List<QueryDocumentSnapshot> docs) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(right: 6, bottom: 4),
        child: InkWell(
          onTap: () {
            if (docs.isEmpty) {
              if (formKey.currentState!.validate()) {
                sendAddresstoFirestore(
                  user,
                  addressModel,
                  countryController,
                  cityController,
                  districtController,
                  streetController,
                  buildingNumberController,
                  flatNumberController,
                  otherController,
                );
              } else {
                Fluttertoast.showToast(msg: "Please Fill All Field");
              }
            } else {
              if (formKey.currentState!.validate()) {
                upgradeAddress(
                  user,
                  addressModel,
                  countryController,
                  cityController,
                  districtController,
                  streetController,
                  buildingNumberController,
                  flatNumberController,
                  otherController,
                );
              } else {
                Fluttertoast.showToast(msg: "Please Fill All Field");
              }
            }
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16)),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 3),
                    blurRadius: 3,
                    spreadRadius: 2,
                    color: Colors.red.withOpacity(0.2),
                  )
                ]),
            height: 40,
            width: double.infinity,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Add New Address",
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),
                  Icon(
                    Icons.add,
                    color: Colors.black,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
