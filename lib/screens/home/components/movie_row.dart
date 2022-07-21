import 'package:flutter/material.dart';
import 'package:testapp/constans.dart';
import 'package:testapp/model/movie.dart';
import 'package:testapp/screens/home/components/movie_item.dart';

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


