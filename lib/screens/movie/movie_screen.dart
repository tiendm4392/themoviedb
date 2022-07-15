import 'package:flutter/material.dart';
import 'package:testapp/model/movie.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(movie.title),
      ),
      body: Center(child: Text(movie.title)),
    );
  }
}
