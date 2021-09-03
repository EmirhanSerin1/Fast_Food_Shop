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
              Container(
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFDBF0FF),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      spreadRadius: 3,
                      color: Colors.grey.withOpacity(0.5),
                      offset: Offset(0, 3),
                    )
                  ],
                  image: DecorationImage(
                    image: AssetImage("assets/user/person.png"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
          
        ],
      ),
    );
  }
}
