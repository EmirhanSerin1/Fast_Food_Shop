import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_food_shop/screens/home/elements/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/product.dart';
import '../../../providers/search_provider.dart';

class Productslist extends StatefulWidget {
  Productslist({Key? key}) : super(key: key);

  @override
  State<Productslist> createState() => _ProductslistState();
}

class _ProductslistState extends State<Productslist> {
  bool isInit = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            Center(
              child: CircularProgressIndicator()
            );
            return SizedBox();
          } else {
            List<QueryDocumentSnapshot> docs = snapshot.data.docs;
            final productList = docs.map(
              (e) {
                return Product(
                  id: e.id,
                  name: e["name"],
                  image: e["image"],
                  price: e["price"],
                  details: e["details"]
                );
              },
            ).toList();
            Provider.of<SearchProvider>(context, listen: false)
                .setItems(productList);

            return Consumer<SearchProvider>(builder: (context, value, child) {
              List<Product> liste = [];
              
              //For check
              if (value.newList.isEmpty) {
                liste = value.itemsList;
              } else {
                liste = value.newList;

              }

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: liste.length,
                itemBuilder: (context, index) {
                  return ProductItem(
                    foodName: liste[index].name,
                    imagePath: liste[index].image,
                    price: liste[index].price,
                    details: liste[index].details,
                    color: Color(0xFFFD6750),
                    textColor: Colors.white,
                  );
                },
              );
            });
          }
        },
      ),
    );
  }
}
