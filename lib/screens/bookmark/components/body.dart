import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/constans.dart';
import 'package:testapp/model/bookmark.dart';
import 'package:testapp/model/list_movie_management.dart';
import 'package:testapp/network/bookmark.dart';
import 'movie_item.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late ListMovieManagement favoriteData;
  late bool isLoaded;

  @override
  void initState() {
    super.initState();
    favoriteData = Provider.of<ListMovieManagement>(context, listen: false);
    getData();
  }

  getData() async {
    if (mounted) {
      setState(() {
        isLoaded = false;
      });
      var data = await Bookmark().getListBookmark();
      print(data);
      // getMovies(data.ids);
      if (mounted) {
        setState(() {
          isLoaded = true;
        });
      }
    }
  }

  getMovies(List<int> ids) async {
    if (favoriteData.getFavorite.isEmpty) {
      await favoriteData.fetchBookmark(ids: ids);
    }
  }

  @override
  Widget build(BuildContext context) {
    var result = Provider.of<ListMovieManagement>(context, listen: false);
    var movieData = result.getFavorite;

    return Visibility(
      visible: isLoaded,
      replacement: const Center(child: CircularProgressIndicator()),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
            itemCount: movieData.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index < movieData.length) {
                return Padding(
                  padding: EdgeInsets.only(
                      bottom:
                          index + 1 == movieData.length ? kDefaultPadding : 0),
                  child: MovieItem(
                    movie: movieData[index],
                  ),
                );
              } else {
                return const Padding(
                    padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ));
              }
            }),
      ),
    );
  }
}
