import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/network/bookmark.dart';
import '../constans.dart';
import '../model/movie.dart';
import '../screens/movie/movie_screen.dart';

class MovieItem extends StatefulWidget {
  const MovieItem({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  State<MovieItem> createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User?>(context);

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
                      movie: widget.movie,
                    )),
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: widget.movie.posterPath != ''
                  ? CachedNetworkImage(
                      width: 95,
                      height: 120,
                      fit: BoxFit.cover,
                      imageUrl:
                          'https://image.tmdb.org/t/p/original/${widget.movie.posterPath}',
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
                    widget.movie.title,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Text(
                    "Release Date",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(widget.movie.releaseDate ??
                      widget.movie.firstAirDate ??
                      'unknown'),
                  const Text(
                    "Average Rating",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(widget.movie.voteAverage.toStringAsFixed(1)),
                ],
              ),
            ),
            const Spacer(),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    if (user == null) return;
                    Bookmark().addBookmark(user.uid, widget.movie.id);
                  },
                  child: const Icon(
                    Icons.bookmark,
                    color: kLightGreenColor,
                  ),
                ),
                const Padding(
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
