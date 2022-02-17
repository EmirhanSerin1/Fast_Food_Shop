import 'package:fast_food_shop/screens/authentication/login/login_screen.dart';
import 'package:flutter/material.dart';

class SingUpScreen extends StatefulWidget {
  SingUpScreen({Key? key}) : super(key: key);

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final firstNameController = new TextEditingController();
  final secondNameController = new TextEditingController();
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  final confirmPasswordController = new TextEditingController();

  final EdgeInsetsGeometry padding = const EdgeInsets.fromLTRB(16, 4, 16, 4);

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
                  signUpButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  firsNameField() {
    return Padding(
      padding: padding,
      child: TextFormField(
        autofocus: false,
        controller: firstNameController,
        keyboardType: TextInputType.emailAddress,
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
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.vpn_key_outlined,
                color: Theme.of(context).primaryColor),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Email",
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
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.vpn_key_outlined,
                color: Theme.of(context).primaryColor),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Email",
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
            Navigator.push(context, MaterialPageRoute(builder:(context)=> LoginScreen()));
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
}
