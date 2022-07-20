import 'package:flutter/material.dart';
import 'package:testapp/constans.dart';
import 'package:testapp/model/movie.dart';
import 'package:testapp/model/movie_management.dart';
import 'package:testapp/network/network_request.dart';
import 'package:testapp/screens/movie/movie_screen.dart';
import 'package:provider/provider.dart';

class MovieList extends StatefulWidget {
  const MovieList({
    Key? key,
    this.param,
    this.genres,
  }) : super(key: key);

  final String? param, genres;

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  // List<Movie>? movieData;
  TextEditingController controller = TextEditingController();
  var isLoaded = true;
  var scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    // getMovies();
    final moviesData = Provider.of<MoviesManagement>(context, listen: false);
    moviesData.getMovieListData(reset: true);
  }

  // getMovies() async {
  //   if (widget.param != null) {
  //     movieData =
  //         await NetworkRequest.getMovies(param: widget.param, time: "day");
  //   } else {
  //     movieData = await NetworkRequest.getMovies(genres: widget.genres);
  //   }
  //   if (movieData != null && mounted) {
  //     setState(() {
  //       isLoaded = true;
  //     });
  //   }
  // }

  // searchMovie(value) async {
  //   if (value != null) {
  //     setState(() {
  //       isLoaded = false;
  //     });
  //     movieData = await NetworkRequest.searchMovies(query: value);
  //     setState(() {
  //       isLoaded = true;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final movieModel = Provider.of<MoviesManagement>(context);
    final movieData = movieModel.movies;

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
                      hintText: "Search with title...",
                      prefixIcon:
                          const Icon(Icons.search, color: kLightGreenColor),
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.text = "";
                          // getMovies();
                          movieModel.getMovieListData(reset: false);
                        },
                        icon: const Icon(Icons.clear, color: kLightGreenColor),
                      ),
                    ),
                    // onChanged: (value) {
                    //   searchMovie(value);
                    // },
                    controller: controller,
                    onSubmitted: (value) {
                      // searchMovie(value);
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
                  movieData?.length != 0
                      ? RefreshIndicator(
                          onRefresh: () async {
                            movieModel.getMovieListData(reset: false);
                            print('haha');
                          },
                          child: ListView.builder(
                              // shrinkWrap: true,
                              // physics: const ScrollPhysics(),
                              itemCount: movieData?.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      bottom: index + 1 == movieData?.length
                                          ? kDefaultPadding
                                          : 0),
                                  child: MovieItem(
                                      movie: movieData?[index],
                                      image: movieData?[index].posterPath,
                                      title: movieData?[index].originalTitle,
                                      date: movieData?[index]
                                          .releaseDate
                                          .toString(),
                                      rate: movieData?[index]
                                          .voteAverage
                                          .toString()),
                                );
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

class MovieItem extends StatelessWidget {
  const MovieItem({
    Key? key,
    required this.image,
    required this.title,
    required this.date,
    required this.rate,
    required this.movie,
  }) : super(key: key);

  final String? image, title, date, rate;
  final Movie? movie;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieScreen(
                      movie: movie!,
                    )),
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                'https://image.tmdb.org/t/p/original/$image',
                width: 95,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: size.width / 1.8,
              padding: const EdgeInsets.only(left: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Title:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    title!,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Text(
                    "Release Date",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(date!.substring(0, 10)),
                  const Text(
                    "Average Rating",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(rate!),
                ],
              ),
            ),
            const Spacer(),
            Column(
              children: const [
                Icon(
                  Icons.bookmark,
                  color: kLightGreenColor,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Icon(
                    Icons.star,
                    color: kLightGreenColor,
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
