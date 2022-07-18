import 'package:flutter/material.dart';
import 'package:testapp/constans.dart';
import 'package:testapp/model/movie.dart';
import 'package:testapp/screens/movie/components/movie_details.dart';
import 'package:testapp/screens/movie/components/movie_poster.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const List<Tab> myTabs = <Tab>[
      Tab(text: "About"),
      Tab(text: "Reviews"),
    ];
    return DefaultTabController(
      length: myTabs.length,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MoviePoster(size: size, widget: widget),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: kDefaultPadding),
                    child: Container(
                      height: 50,
                      width: 200,
                      decoration: const BoxDecoration(
                          // border: Border(
                          //     bottom: BorderSide(width: 2, color: kGrayColor)),
                          color: Colors.white),
                      child: const TabBar(
                          labelColor: kPrimaryColor,
                          unselectedLabelColor: Colors.black,
                          indicatorColor: kPrimaryColor,
                          tabs: myTabs),
                    ),
                  ),
                  MovieDetails(widget: widget),
                  // Expanded(
                  //   child: TabBarView(
                  //     children: [
                  //       const Center(
                  //           child: Text(
                  //         "No review",
                  //         style: headerText,
                  //       )),
                  //       MovieDetails(widget: widget),
                  //     ],
                  //   ),
                  // )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

