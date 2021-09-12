import 'package:fast_food_shop/core/profiile_photo/profil_photo.dart';
import 'package:flutter/material.dart';

buildCustomAppbar(BuildContext context) {
  return Padding(
    padding: EdgeInsets.all(15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Builder(
            builder: (context) => Container(
                  alignment: Alignment.center,
                  child: IconButton(
                    onPressed: () => Scaffold.of(context).openDrawer(),
                    icon: Icon(Icons.menu),
                    color: Colors.black,
                  ),
                )),
        buildProfilPhoto(50, 50)
      ],
    ),
  );
}


