import 'package:flutter/material.dart';
import 'package:testapp/constans.dart';

class ChattingRoom extends StatelessWidget {
  const ChattingRoom({Key? key, required this.name, required this.message})
      : super(key: key);
  static String routeName = "/chatRoom";

  final String name, message;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(name, style: headerText),
            Text(message, style: headerText)
          ],
        ),
      ),
    );
  }
}

// class Message {
//   final String name;
//   final String message;

//   const Message(this.name, this.message);
// }
