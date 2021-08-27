import 'package:flutter/material.dart';

buildLikeandReturn() {
    return Column(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(1, 3),
                          blurRadius: 4,
                          color: Color(0xFFF56953).withOpacity(0.2),
                        ),
                      ],
                      color: Color(0xFFFFFFFF)),
                  child: Icon(
                    Icons.favorite_border_outlined,
                    color: Color(0xFFF56953),
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(1, 3),
                          blurRadius: 4,
                          color: Color(0xFFF56953).withOpacity(0.2),
                        ),
                      ],
                      color: Color(0xFFFFFFFF)),
                  child: Icon(
                    Icons.restore,
                    color: Color(0xFFF56953),
                  ),
                ),
              ],
            );
  }