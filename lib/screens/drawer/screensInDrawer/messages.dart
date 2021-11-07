import 'package:flutter/material.dart';

class Messages extends StatefulWidget {
  const Messages({Key key}) : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 8, 12),
                child: Icon(Icons.arrow_back),
              ),
            ],
          ),
          buildMessageBox("", "Alessadra Omeliove"),
          buildMessageBox("", "Chris Toc"),
          buildMessageBox("", "Angelina Tear"),
          buildMessageBox("", "Angelina Tear"),
          buildMessageBox("", "Angelina Tear"),
          buildMessageBox("", "Angelina Tear"),
          buildMessageBox("", "Angelina Tear"),
        ],
      ),
    );
  }

  Padding buildMessageBox(String imagePath, String name) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Color(0xFFF56953), boxShadow: [
          BoxShadow(
            blurRadius: 3,
            color: Colors.grey.withOpacity(0.5),
            offset: Offset(0, 3),
            spreadRadius: 2,
          ),
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    name,
                    style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
