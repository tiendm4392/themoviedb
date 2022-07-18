import 'package:flutter/material.dart';
import 'package:testapp/constans.dart';
import 'package:testapp/model/movie.dart';
import 'package:testapp/screens/movie/movie_screen.dart';

class MovieRow extends StatelessWidget {
  const MovieRow({
    Key? key,
    required this.movieType,
  }) : super(key: key);

  final List<Movie>? movieType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200.0,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movieType?.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(
                    left: index == 0 ? 10.0 : 0,
                    right:
                        index + 1 == movieType?.length ? kDefaultPadding : 0),
                child: MovieItem(
                  image: movieType![index].posterPath,
                  movie: movieType![index],
                ),
              );
            }));
  }
}

class MovieItem extends StatelessWidget {
  const MovieItem({
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
        height: 200,
        width: 120,
        padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
        margin: const EdgeInsets.only(left: kDefaultPadding / 2),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(kDefaultPadding / 2),
          child: Image.network(
            "https://image.tmdb.org/t/p/original$image",
            width: 120,
            height: 180,
            fit: BoxFit.contain,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Container(
                height: 190,
                width: 110,
                decoration: BoxDecoration(
                  color: kGrayColor,
                  borderRadius: BorderRadius.circular(kDefaultPadding / 2),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
