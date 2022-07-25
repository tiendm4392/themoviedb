import 'package:flutter/material.dart';
import 'package:testapp/screens/discover/components/body.dart';
import 'package:testapp/constans.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key, this.param, this.genres, this.title})
      : super(key: key);
  final String? param, genres, title;
  static String routeName = "/discover";

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(genres: widget.genres ?? '', param: widget.param,),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.black, //change your color here
      ),
      elevation: 0.4,
      backgroundColor: Colors.white,
      title: Text(
        widget.title ?? "Discover",
        style: headerText,
      ),
    );
  }
}
