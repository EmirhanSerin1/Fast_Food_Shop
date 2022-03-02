import 'package:fast_food_shop/screens/authentication/sign_up/sign_up.dart';
import 'package:fast_food_shop/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final EdgeInsetsGeometry padding = const EdgeInsets.fromLTRB(16, 4, 16, 4);

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  emailField(),
                  passwordField(),
                  loginButton(),
                  signUp(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  loginButton() {
    return Padding(
      padding: padding,
      child: Material(
        color: Theme.of(context).primaryColor,
        elevation: 5,
        shadowColor: Colors.grey,
        borderRadius: BorderRadius.circular(18),
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width/2,
          onPressed: () {
            signIn(emailController.text, passwordController.text);
          },
          child: Text(
            "Login",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  emailField() {
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
            return "Please Enter a Valid Email";
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.mail, color: Theme.of(context).primaryColor),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Email",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }

  passwordField() {
    return Padding(
      padding: padding,
      child: TextFormField(
        obscureText: true,
        autofocus: false,
        controller: passwordController,
        validator: (value) {
          RegExp regExp = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return "Please Enter Your Password";
          }
          if (!regExp.hasMatch(value)) {
            return "Please Enter a Valid Password. Minimum 6 Character";
          }
          return null;
        },
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
            prefixIcon:
                Icon(Icons.vpn_key, color: Theme.of(context).primaryColor),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Password",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }

  signUp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don't have any account? "),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SingUpScreen()));
          },
          child: Text(
            "SignUp",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Theme.of(context).primaryColor,
            ),
          ),
        )
      ],
    );
  }

  // login function
  void signIn(String email, password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Login Successful"),
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MyHomePage()))
                });
      } on Exception catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }
}
