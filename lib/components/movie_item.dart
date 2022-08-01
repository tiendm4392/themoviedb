import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/components/globla_dialog.dart';
import 'package:testapp/model/list_movie_management.dart';
import 'package:testapp/network/bookmark.dart';
import '../constans.dart';
import '../model/movie.dart';
import '../screens/movie/movie_screen.dart';

class MovieItem extends StatefulWidget {
  const MovieItem({
    Key? key,
    required this.movie,
    this.onPress,
    this.isBookmarked,
  }) : super(key: key);

  final Movie movie;
  final Function? onPress;
  final bool? isBookmarked;

  @override
  State<MovieItem> createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  late ListMovieManagement listBookMark;
  late bool check = true;
  @override
  void initState() {
    super.initState();
    listBookMark = Provider.of<ListMovieManagement>(context, listen: false);
    setCheck();
  }

  setCheck() {
    if (mounted) {
      setState(() {
        check = listBookMark.getFavoriteIds.contains(widget.movie.id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // var result = Provider.of<ListMovieManagement>(context, listen: false);
    // var movieData = result.getFavoriteIds;
    var user = Provider.of<User?>(context);
    if (user == null && mounted) {
      setState(() {
        check = false;
      });
    }
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
              ),
            ),
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
                  onTap: user == null
                      ? () {
                          GlobalDialog().showMyDialog(
                              context: context,
                              message:
                                  'Please sign in to use this feature',
                              title: 'Note');
                        }
                      : () async {
                          await Bookmark()
                              .addBookmark(user.uid, widget.movie.id);
                          if (widget.isBookmarked != null) {
                            setState(() {
                              check = !check;
                            });
                          }
                          if (widget.onPress != null) {
                            widget.onPress!();
                          }
                        },
                  child: Icon(
                    Icons.bookmark,
                    color: check ? kLightGreenColor : kGrayColor,
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
