import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testapp/constans.dart';
import 'package:testapp/model/movie.dart';
import 'package:testapp/network/network_request.dart';
import 'package:testapp/screens/movie/movie_screen.dart';
import '../../../components/sectrion_with_button.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Movie>? movieData = [];
  List<Movie>? actionMovie = [];
  List<Movie>? animationMovie = [];
  List<Movie>? tvShow = [];
  int _current = 0;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getMovies();
  }

  getMovies() async {
    var results =
        await NetworkRequest.getMovies(param: "trending", time: "day");
    var action =
        await NetworkRequest.getMovies(param: "discover", genres: "28");
    var animation =
        await NetworkRequest.getMovies(param: "discover", genres: "16");
    var tvShowResult =
        await NetworkRequest.getMovies(param: "discover", genres: "27");
    tvShow = tvShowResult?.sublist(0, 11);
    animationMovie = animation?.sublist(0, 11);
    actionMovie = action?.sublist(0, 11);
    movieData = results?.sublist(0, 5);
    if (movieData != null && actionMovie != null) {
      if (mounted) {
        setState(() {
          isLoaded = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    final List<Widget> imageSliders = movieData!
        .map(
          (item) => Container(
            margin: const EdgeInsets.all(10),
            width: 1000,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: NetworkImage(
                  "https://image.tmdb.org/t/p/original${item.backdropPath}",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(10)),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          item.title,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ))
                ]) /* add child content here */,
          ),
        )
        .toList();

    return Visibility(
      visible: isLoaded,
      replacement: const Center(child: CircularProgressIndicator()),
      child: (SingleChildScrollView(
        child: Column(children: [
          const SectionWithButton(
            title: 'Top Trending',
          ),
          Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                    autoPlay: false,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
                items: imageSliders,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: movieData!.asMap().entries.map((entry) {
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black)
                            .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                  );
                }).toList(),
              ),
            ],
          ),
          const SectionWithButton(title: "Action"),
          SizedBox(
              height: 200.0,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: actionMovie?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ActionList(
                        image: actionMovie![index].posterPath,
                        movie: actionMovie![index]);
                  })),
          const SectionWithButton(title: "Animation"),
          SizedBox(
              height: 200.0,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: animationMovie?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ActionList(
                        image: animationMovie![index].posterPath,
                        movie: animationMovie![index]);
                  })),
          const SectionWithButton(title: "Horror"),
          SizedBox(
              height: 200.0,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tvShow?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ActionList(
                      image: tvShow![index].posterPath,
                      movie: tvShow![index],
                    );
                  })),
        ]),
      )),
    );
  }
}

class ActionList extends StatelessWidget {
  const ActionList({
    Key? key,
    required this.image,
    required this.movie,
  }) : super(key: key);

  final String image;
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MovieScreen(
                    movie: movie,
                  )),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
        margin: const EdgeInsets.only(left: kDefaultPadding),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(kDefaultPadding / 2),
          child: Image.network(
            "https://image.tmdb.org/t/p/original$image",
            width: 120,
            height: 180,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}