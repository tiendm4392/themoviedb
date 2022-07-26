import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../constans.dart';
import '../model/movie.dart';
import '../screens/movie/movie_screen.dart';

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
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieScreen(
                      movie: movie,
                    )),
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: image != ''
                  ? CachedNetworkImage(
                      width: 95,
                      height: 120,
                      fit: BoxFit.cover,
                      imageUrl: 'https://image.tmdb.org/t/p/original/$image',
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
                    title!,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Text(
                    "Release Date",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(date == '' ? 'unknown' : date!),
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
