import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:testapp/constans.dart';
import 'package:testapp/model/movie_detail.dart';
import 'package:testapp/screens/movie/components/movie_details.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final MovieDetail movie;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => MovieScreen(
          //             movie: movie,
          //           )),
          // );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: movie.posterPath != ''
                  ? CachedNetworkImage(
                      width: 95,
                      height: 120,
                      fit: BoxFit.cover,
                      imageUrl:
                          'https://image.tmdb.org/t/p/original/${movie.posterPath}',
                      placeholder: (context, url) => Container(
                        decoration: const BoxDecoration(
                          color: kGrayColor,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    )
                  : Container(
                      height: 120,
                      width: 95,
                      color: kGrayColor,
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
                    movie.title,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Text(
                    "Release Date",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(movie.releaseDate),
                  const Text(
                    "Average Rating",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(movie.voteAverage.toString()),
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
