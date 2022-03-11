import 'package:flutter/material.dart';

class SelectedFoodImage extends StatelessWidget {
  const SelectedFoodImage(
      {Key? key, required this.heroTag, required this.imagePath})
      : super(key: key);

  final String heroTag, imagePath;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: NetworkImage(imagePath),
          fit: BoxFit.contain,
        )),
      ),
    );
  }
}
