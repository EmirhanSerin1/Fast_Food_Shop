import 'package:fast_food_shop/core/profiile_photo/profil_photo.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildProfilPhoto(130, 130)
              
            ],
          ),
          
        ],
      ),
    );
  }
}
