import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Adress extends StatefulWidget {
  const Adress({Key? key}) : super(key: key);

  @override
  State<Adress> createState() => _AdressState();
}

class _AdressState extends State<Adress> {
  final cityController = TextEditingController();
  final streetController = TextEditingController();
  final buildingNumberController = TextEditingController();
  final doorNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;

    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              children: [
                buildField(cityController),
                Container(),
              ],
            )
          ],
        ),
      ),
    );
  }

  buildField(TextEditingController controller) {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width/2.2,
      child: Center(
            child: TextFormField(
              autofocus: false,
              controller: controller,
              textInputAction: TextInputAction.next,
              maxLength: 16,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(12, 15, 15, 11),
                hintText: "XXXX XXXX XXXX XXXX",
                labelStyle: TextStyle(fontSize: 18),
                hintStyle: TextStyle(fontSize: 16),
                counterStyle: TextStyle(fontSize: 2),
                errorStyle: TextStyle(fontSize: 2),
                counterText: '',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1.0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                ),
              ),
              validator: (value) {
                RegExp regExp = new RegExp(r'^.{,}$');
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
    );
  }
}
