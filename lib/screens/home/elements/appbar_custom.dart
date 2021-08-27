import 'package:flutter/material.dart';

buildCustomAppbar() {
    return Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.menu, color: Colors.black),
              Container(
                height: 50,
                width: 50,
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
              )
            ],
          ),
        );
  }