import 'package:flutter/material.dart';

 buildProfilPhoto(double height, double width) {
  return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 5,
                spreadRadius: 3,
                offset: Offset(0, 3),
              ),
            ],
            color: Color(0xFFDBF0FF),
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage("assets/user/person.png"),
              fit: BoxFit.contain,
            )),
      );
}