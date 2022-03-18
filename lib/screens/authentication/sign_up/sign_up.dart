import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_food_shop/models/user.dart';
import 'package:fast_food_shop/screens/authentication/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum SingingCharacter { male, female }

class SingUpScreen extends StatefulWidget {
  SingUpScreen({Key? key}) : super(key: key);

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;

  final firstNameController = new TextEditingController();
  final secondNameController = new TextEditingController();
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  final confirmPasswordController = new TextEditingController();

  final EdgeInsetsGeometry padding = const EdgeInsets.fromLTRB(16, 4, 16, 4);

  SingingCharacter? _character = SingingCharacter.male;
  String male = "Male";
  String female = "Female";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
          color: Theme.of(context).primaryColor,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  firsNameField(),
                  secondNameField(),
                  emailSingUpField(),
                  passwordSingUpField(),
                  confirmPasswordSingUpField(),
                  maleFemaleRadio(),
                  signUpButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  maleFemaleRadio() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            height: 40,
            width: 100,
            child: Center(
              child: Row(
                children: [
                  Text('Male'),
                  Radio<SingingCharacter>(
                    value: SingingCharacter.male,
                    groupValue: _character,
                    onChanged: (SingingCharacter? value) {
                      setState(() {
                        _character = value;
                      });
                      print(_character.toString());
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 40,
            width: 100,
            child: Row(
              children: [
                Text('Female'),
                Radio<SingingCharacter>(
                  value: SingingCharacter.female,
                  groupValue: _character,
                  onChanged: (SingingCharacter? value) {
                    setState(() {
                      _character = value;
                    });
                    print(_character.toString());
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  firsNameField() {
    return Padding(
      padding: padding,
      child: TextFormField(
        autofocus: false,
        controller: firstNameController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          RegExp regExp = new RegExp(r'^.{2,}$');
          if (value!.isEmpty) {
            return "First Name Cannot Be Empty";
          }
          if (!regExp.hasMatch(value)) {
            return "Please Enter a Valid Name. Minimum 2 Character";
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.person_outlined,
                color: Theme.of(context).primaryColor),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "First Name",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }

  secondNameField() {
    return Padding(
      padding: padding,
      child: TextFormField(
        autofocus: false,
        controller: secondNameController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          RegExp regExp = new RegExp(r'^.{2,}$');
          if (value!.isEmpty) {
            return "Second Name Aannot Be Empty";
          }
          if (!regExp.hasMatch(value)) {
            return "Please Enter a Valid Name. Minimum 2 Character";
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.person_outlined,
                color: Theme.of(context).primaryColor),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Second Name",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }

  emailSingUpField() {
    return Padding(
      padding: padding,
      child: TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please Enter Your Email";
          }
          if (!RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value)) {
            return "Please Enter a valid email";
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon:
                Icon(Icons.mail_outline, color: Theme.of(context).primaryColor),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Email",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }

  passwordSingUpField() {
    return Padding(
      padding: padding,
      child: TextFormField(
        obscureText: true,
        autofocus: false,
        controller: passwordController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          RegExp regExp = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return "Password Cannot Be Empty";
          }
          if (!regExp.hasMatch(value)) {
            return "Please Enter a Valid Password. Minimum 6 Character";
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.vpn_key_outlined,
                color: Theme.of(context).primaryColor),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Password",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }

  confirmPasswordSingUpField() {
    return Padding(
      padding: padding,
      child: TextFormField(
        obscureText: true,
        autofocus: false,
        controller: confirmPasswordController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (passwordController.text != confirmPasswordController.text) {
            return "Password do not match";
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.vpn_key_outlined,
                color: Theme.of(context).primaryColor),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Confirm Password",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }

  signUpButton() {
    return Padding(
      padding: padding,
      child: Material(
        color: Theme.of(context).primaryColor,
        elevation: 5,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(18),
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            signUP(emailController.text, passwordController.text);
          },
          child: Text(
            "Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  void signUP(String email, password) async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);

        await userCredential.user?.updateDisplayName(
          firstNameController.text.trim() +
              " " +
              secondNameController.text.trim(),
        );

        await userCredential.user
            ?.updatePhotoURL("https://randomuser.me/api/portraits/men/75.jpg");

        await sendDetailsToFirestore();
      } on Exception catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }

  sendDetailsToFirestore() async {
    // calling firestore
    // calling user model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    String sex = "";

    if(_character == SingingCharacter.male){
      sex = male;
    } else{
      sex = female;
    }

    userModel.uid = user!.uid;
    userModel.email = user.email;
    userModel.firstName = firstNameController.text;
    userModel.secondName = secondNameController.text;
    userModel.sex = sex;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created succesfully");

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false);
  }
}
