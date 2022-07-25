import 'package:flutter/material.dart';
import 'package:testapp/constans.dart';
import 'package:testapp/screens/movie/components/body.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final Body widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Overview:",
          style: sectionText,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: kDefaultPadding / 2),
          child: Text(widget.movie.overview),
        ),
        const Text(
          "Release Date:",
          style: sectionText,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: kDefaultPadding / 2),
          child: Text(widget.movie.releaseDate != ''
              ? widget.movie.releaseDate!
              : 'unknown'),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: kDefaultPadding / 2),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Average Rating:",
                    style: sectionText,
                  ),
                  Text(widget.movie.voteAverage.toString()),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Rate Count:",
                      style: sectionText,
                    ),
                    Text(widget.movie.voteCount.toString()),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Text(
          "Popularity:",
          style: sectionText,
        ),
        Text(widget.movie.popularity.toString()),
      ],
    );
  }
}
