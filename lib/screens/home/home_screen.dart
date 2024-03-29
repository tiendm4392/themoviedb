import 'package:flutter/material.dart';
import 'package:testapp/constans.dart';
import 'package:testapp/screens/home/components/body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: const Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0.3,
      backgroundColor: Colors.white,
      title: const Text(
        "MovieZ",
        style: headerText,
      ),
      actions: [
        IconButton(
          onPressed: () {
            
          },
          icon: const Icon(
            Icons.notifications,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
