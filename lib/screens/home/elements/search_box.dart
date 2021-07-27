import 'package:flutter/material.dart';

buildSearchBox() {
  return Padding(
    padding: EdgeInsets.only(left: 16, right: 16),
    child: Container(
      padding: EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search",
          hintStyle: TextStyle(fontSize: 14),
          border: InputBorder.none,
          fillColor: Colors.grey.withOpacity(0.4),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
          ),
        ),
      ),
    ),
  );
}
