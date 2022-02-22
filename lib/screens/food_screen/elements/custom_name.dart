import 'package:flutter/material.dart';

class CustomName extends StatelessWidget {
  const CustomName({
    Key? key,
    required this.text,
  }) : super(key: key);

  final text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 8, 0, 0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}