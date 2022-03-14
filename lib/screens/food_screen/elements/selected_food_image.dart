import 'package:cached_network_image/cached_network_image.dart';
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
      child: CachedNetworkImage(imageUrl: imagePath, width: double.infinity, height: 200,)
    );
  }
}
