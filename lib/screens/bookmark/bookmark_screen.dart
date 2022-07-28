import 'package:flutter/material.dart';
import 'package:testapp/screens/bookmark/components/body.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

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
        "Bookmark",
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
