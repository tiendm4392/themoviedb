import 'package:flutter/material.dart';
import 'package:testapp/model/movie.dart';

import 'components/body.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(movie: movie),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.black, //change your color here
      ),
      centerTitle: true,
      elevation: 0.3,
      backgroundColor: Colors.white,
      title: Text(
        movie.title,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
