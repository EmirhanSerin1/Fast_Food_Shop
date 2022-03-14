import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/search_provider.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({Key? key}) : super(key: key);

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {


  

  @override
  Widget build(BuildContext context) {
    SearchProvider prov = Provider.of<SearchProvider>(context, listen: false);
    final controller =
        Provider.of<SearchProvider>(context, listen: false).nameController;

    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Container(
        padding: EdgeInsets.only(left: 6),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          autofocus: false,
          onChanged: (name) {
            prov.onSearch();
            if (controller.text.isEmpty) {
              FocusScope.of(context).unfocus();
            }
          },
          controller: controller,
          decoration: InputDecoration(
            hintText: "Search",
            hintStyle: TextStyle(fontSize: 14),
            border: InputBorder.none,
            fillColor: Colors.grey.withOpacity(0.4),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                controller.clear();
                prov.onSearch();
                FocusScope.of(context).unfocus();
              },
              icon: Icon(Icons.clear),
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
