import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OrderItem extends StatefulWidget {
  const OrderItem(
      {Key? key,
      required this.totalPrice,
      required this.orderDate,
      required this.orders,
      required this.snapshot,
      required this.index,
      required this.docs,
      required this.address})
      : super(key: key);

  final totalPrice;
  final orderDate;
  final orders;
  final index;
  final address;

  final AsyncSnapshot snapshot;
  final List<QueryDocumentSnapshot> docs;

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  @override
  Widget build(BuildContext context) {
    dynamic orderStart = widget.docs.map((e) => e["orders"]).toList();
    List ordersList = orderStart[widget.index].values.toList();

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
                  color: Colors.red.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(0, 3))
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text("Total: ",
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  Text(
                    widget.totalPrice.toString() + "\$",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text("Order Date: ",
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  Text(
                    widget.orderDate.toString(),
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                _showAlertdialog(widget.snapshot, ordersList);
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: FaIcon(
                  FontAwesomeIcons.question,
                  size: 15,
                  color: Colors.red,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                _showDeliverAlertdialog(widget.snapshot, ordersList);
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: FaIcon(
                  FontAwesomeIcons.locationArrow,
                  size: 15,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showAlertdialog(AsyncSnapshot snapshot, List<dynamic> ordersList) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Orders'),
        content: getOrders(ordersList),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  _showDeliverAlertdialog(AsyncSnapshot snapshot, List<dynamic> ordersList) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Orders'),
        content: Text(widget.address),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  getOrders(List<dynamic> ordersList) {
    return Container(
      height: 80,
      child: ListView.builder(
        itemCount: ordersList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ordersList[index]["name"].toString() +
                      " x" +
                      ordersList[index]["numberOfproduct"].toString(),
                ),
                Text(getExtras(index), style: TextStyle(color: Colors.grey)),
              ],
            ),
          );
        },
      ),
    );
  }

  getExtras(var indexPro) {
    dynamic orderStart = widget.docs.map((e) => e["orders"]).toList();
    List ordersList = orderStart[widget.index].values.toList();

    dynamic extras = ordersList[indexPro]["extras"];

    dynamic extrass = extras.values;

    dynamic extraName = extrass.map((e) => e["name"]).toList();

    List extraCheck = extrass.toList();

    if (extraCheck.isEmpty) {
      return "No Extras";
    } else {
      return extraName.toString();
    }
  }
}
