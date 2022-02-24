
import 'package:fast_food_shop/screens/food_screen/selected_foods.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  const ProductList({
    Key? key,
    required this.foodName,
    required this.imagePath,
    required this.price,
    required this.color,
    required this.textColor,
  }) : super(key: key);

  final String foodName, imagePath, price;
  final color, textColor;

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, top: 4, bottom: 8),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SellectedFood(
                foodName: widget.foodName,
                price: widget.price,
                imagePath: widget.imagePath,
                heroTag: widget.foodName,
              ),
            ),
          );
        },
        child: Container(
          height: 174,
          width: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: widget.color,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(1, 3),
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 2,
                )
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: widget.foodName,
                child: Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child:
                        Image.network(widget.imagePath, height: 50, width: 50),
                  ),
                ),
              ),
              SizedBox(height: 25),
              Text(
                widget.foodName,
                style: TextStyle(fontSize: 17, color: widget.textColor, fontWeight: FontWeight.w500),
              ),
              Text(
                "\$" + widget.price,
                style: TextStyle(fontSize: 17, color: widget.textColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
