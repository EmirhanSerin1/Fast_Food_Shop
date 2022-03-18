import 'package:fast_food_shop/models/total_order.dart';
import 'package:flutter/material.dart';

class OrderItem extends StatefulWidget {
  const OrderItem({ Key? key, required this.totalPrice}) : super(key: key);

  final totalPrice;

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 3)
            )
          ]
        ),
        child: Center(child: Text(widget.totalPrice.toString())),
      ),
    );
  }
}