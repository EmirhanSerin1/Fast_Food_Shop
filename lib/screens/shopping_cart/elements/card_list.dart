import 'package:flutter/material.dart';

class CardList extends StatefulWidget {
  const CardList({
    Key? key,
    required this.foodName,
    required this.imagePath,
    required this.price,
  }) : super(key: key);

  final String foodName, imagePath, price;

  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 2,
              offset: Offset(0, 3),
              spreadRadius: 2,
            )
          ]
          
        ),

        child: Text(widget.foodName),
      ),
    );
  }
}
