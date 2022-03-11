import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/search_provider.dart';


buildSearchBox(BuildContext context){
  SearchProvider prov = Provider.of<SearchProvider>(context, listen: false);
    final controller = TextEditingController();
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Container(
        padding: EdgeInsets.only(left: 6),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          onChanged: prov.onSearch,
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
              },
              icon: Icon(Icons.clear),
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
}
