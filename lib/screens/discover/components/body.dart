import 'package:flutter/material.dart';
import 'package:testapp/components/movie_item.dart';
import 'package:testapp/constans.dart';
import 'package:testapp/model/movie_management.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
    this.param,
    this.genres,
  }) : super(key: key);

  final String? param, genres;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController controller = TextEditingController();
  late bool isLoaded;
  var scrollController = ScrollController();
  late MoviesManagement moviesData;
  @override
  void initState() {
    super.initState();
    moviesData = Provider.of<MoviesManagement>(context, listen: false);
    controller.text = moviesData.currentKeyWord;
    getMovies();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        loadMore();
      }
    });
  }

  getMovies() async {
    if (moviesData.movies.isEmpty && controller.text == '') {
      setState(() {
        isLoaded = false;
      });
      await moviesData.getMovieListData(reset: true);
    }
    setState(() {
      isLoaded = true;
    });
  }

  resetSearch() async {
    if (controller.text != '') {
      setState(() {
        isLoaded = false;
      });
      await moviesData.getMovieListData(reset: true);
    }
    setState(() {
      isLoaded = true;
    });
  }

  searchMovie(value) async {
    if (controller.text != '') {
      setState(() {
        isLoaded = false;
      });
      await moviesData.searchMovieListData(reset: true, query: value);
    }
    setState(() {
      isLoaded = true;
    });
  }

  reload() async {
    if (controller.text != '') {
      await moviesData.searchMovieListData(reset: true, query: controller.text);
    } else {
      await moviesData.getMovieListData(reset: true);
    }
  }

  loadMore() {
    if (controller.text == "") {
      moviesData.getMovieListData(reset: false);
    } else {
      moviesData.searchMovieListData(query: controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    var movieModel = Provider.of<MoviesManagement>(context, listen: true);
    var movieData = movieModel.movies;

    return Column(
      children: [
        Visibility(
          visible: widget.param == null && widget.genres == null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: kLightGreenColor,
                padding: const EdgeInsets.symmetric(
                    vertical: kDefaultPadding / 2, horizontal: kDefaultPadding),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(kDefaultPadding / 2),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search with title...",
                      prefixIcon:
                          const Icon(Icons.search, color: kLightGreenColor),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear, color: kLightGreenColor),
                        onPressed: () {
                          resetSearch();
                          controller.text = "";
                        },
                      ),
                    ),
                    controller: controller,
                    onSubmitted: (value) {
                      searchMovie(value);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Visibility(
            visible: isLoaded,
            replacement: const Center(child: CircularProgressIndicator()),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child:
                  // ignore: prefer_is_empty
                  movieData.length != 0
                      ? RefreshIndicator(
                          onRefresh: () => reload(),
                          child: ListView.builder(
                              // shrinkWrap: true,
                              // physics: const ScrollPhysics(),
                              controller: scrollController,
                              itemCount: movieData.length + 1,
                              itemBuilder: (BuildContext context, int index) {
                                if (index < movieData.length) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        bottom: index + 1 == movieData.length
                                            ? kDefaultPadding
                                            : 0),
                                    child: MovieItem(
                                        movie: movieData[index],
                                        image: movieData[index].posterPath,
                                        title: movieData[index].originalTitle,
                                        date: movieData[index]
                                            .releaseDate
                                            .toString(),
                                        rate: movieData[index]
                                            .voteAverage
                                            .toString()),
                                  );
                                } else {
                                  return const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: kDefaultPadding),
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ));
                                }
                              }),
                        )
                      : const Center(
                          child: Text(
                          "No movie found",
                          style: headerText,
                        )),
            ),
          ),
        ),
      ],
    );
  }
}


