import 'package:flutter/material.dart';
import 'package:testapp/constans.dart';
import 'package:testapp/screens/movie/components/body.dart';

class MoviePoster extends StatelessWidget {
  const MoviePoster({
    Key? key,
    required this.size,
    required this.widget,
  }) : super(key: key);

  final Size size;
  final Body widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 310,
      child: Stack(children: [
        Container(
          height: 220,
          width: size.width,
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(10.0),
            color: kGrayColor,
            image: widget.movie.backdropPath != ''
                ? DecorationImage(
                    image: NetworkImage(
                      "https://image.tmdb.org/t/p/original${widget.movie.backdropPath}",
                    ),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
        ),
        Positioned(
          left: kDefaultPadding,
          bottom: 10,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 180,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: kGrayColor,
                  image: widget.movie.posterPath != ''
                      ? DecorationImage(
                          image: NetworkImage(
                            "https://image.tmdb.org/t/p/original${widget.movie.posterPath}",
                          ),
                          fit: BoxFit.cover,
                        )
                      : null,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 1,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: kDefaultPadding / 2),
                child: SizedBox(
                  width: size.width / 1.6,
                  height: 80,
                  child: Padding(
                    padding: const EdgeInsets.only(top: kDefaultPadding / 2),
                    child: Text(widget.movie.title, style: titleText),
                  ),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
