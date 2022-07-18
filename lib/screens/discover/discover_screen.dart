import 'package:flutter/material.dart';
import 'package:testapp/components/movie_list.dart';
import 'package:testapp/constans.dart';
import 'package:testapp/model/movie.dart';
import 'package:testapp/network/network_request.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  List<Movie>? movieData;

  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getMovies();
  }

  getMovies() async {
    movieData = await NetworkRequest.getMovies(param: "discover");
    if (movieData != null) {
      if (mounted) {
        setState(() {
          isLoaded = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: MovieList(isLoaded: isLoaded, movieData: movieData),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0.4,
      backgroundColor: Colors.white,
      title: const Text(
        "Discover",
        style: headerText,
      ),
    );
  }
}

