import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:testapp/constans.dart';
import 'package:testapp/model/movie.dart';
import 'package:testapp/screens/movie/movie_screen.dart';

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
          child: CachedNetworkImage(
            width: 120,
            height: 180,
            fit: BoxFit.cover,
            imageUrl: "https://image.tmdb.org/t/p/original$image",
            placeholder: (context, url) => Container(
              decoration: const BoxDecoration(
                color: kGrayColor,
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
