import 'package:fast_food_shop/providers/address_formKey.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressEdit extends StatefulWidget {
  const AddressEdit({Key? key}) : super(key: key);

  @override
  State<AddressEdit> createState() => _AddressEditState();
}

class _AddressEditState extends State<AddressEdit> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    final _formKey =
        Provider.of<AddressTextField>(context, listen: false).formKey;
    final cityController =  Provider.of<AddressTextField>(context, listen: false).cityController;
    final countryController = Provider.of<AddressTextField>(context, listen: false).countryController;
    final streetController = Provider.of<AddressTextField>(context, listen: false).streetController;
    final districtController =  Provider.of<AddressTextField>(context, listen: false).districtController;
    final buildingNumberController =  Provider.of<AddressTextField>(context, listen: false).buildingNumberController;
    final flatNumberController =  Provider.of<AddressTextField>(context, listen: false).flatNumberController;
    final otherController =  Provider.of<AddressTextField>(context, listen: false).otherController;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildField(
                  streetController, " STREET ", TextInputType.streetAddress),
              buildField(districtController, " DISTRICT ",
                  TextInputType.streetAddress),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildField(buildingNumberController, " BUILDING NUMBER ",
                  TextInputType.number),
              buildField(
                  flatNumberController, " FLAT NUMBER ", TextInputType.number),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildField(cityController, " CITY ", TextInputType.streetAddress),
              buildField(
                  countryController, " COUNTRY ", TextInputType.streetAddress),
            ],
          ),
          buildOtherField(
              otherController, " OTHER ", TextInputType.streetAddress),
        ],
      ),
    );
  }

  buildField(TextEditingController controller, String hintText,
      TextInputType? keyboardType) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 15, 8, 15),
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width / 2.2,
        child: Center(
          child: TextFormField(
            autofocus: false,
            controller: controller,
            textInputAction: TextInputAction.next,
            maxLength: 16,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(12, 15, 15, 11),
              labelText: hintText,
              labelStyle: TextStyle(fontSize: 12),
              counterStyle: TextStyle(fontSize: 2),
              errorStyle: TextStyle(fontSize: 2),
              counterText: '',
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1.0),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black, width: 2.0),
              ),
            ),
            validator: (value) {
              RegExp regExp = new RegExp(r'^.{2,}$');
              if (value!.isEmpty) {
                return "";
              }
              if (!regExp.hasMatch(value)) {
                return "";
              }
              return null;
            },
            onSaved: (value) {
              controller.text = value!;
            },
          ),
        ),
      ),
    );
  }

  buildOtherField(TextEditingController controller, String labelText,
      TextInputType? keyboardType) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 20, 8, 20),
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: TextFormField(
            autofocus: false,
            controller: controller,
            textInputAction: TextInputAction.done,
            maxLength: 16,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(12, 15, 15, 11),
              labelText: labelText,
              labelStyle: TextStyle(fontSize: 12),
              hintStyle: TextStyle(fontSize: 15),
              counterStyle: TextStyle(fontSize: 2),
              errorStyle: TextStyle(fontSize: 2),
              counterText: '',
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1.0),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black, width: 2.0),
              ),
            ),
            validator: (value) {
              RegExp regExp = new RegExp(r'^.{2,}$');
              if (value!.isEmpty) {
                return "";
              }
              if (!regExp.hasMatch(value)) {
                return "";
              }
              return null;
            },
            onSaved: (value) {
              controller.text = value!;
            },
          ),
        ),
      ),
    );
  }
}
