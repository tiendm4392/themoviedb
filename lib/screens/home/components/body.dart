import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/constans.dart';
import 'package:testapp/model/home_management.dart';
import 'package:testapp/screens/discover/discover_screen.dart';
import 'package:testapp/screens/home/components/movie_row.dart';
import 'package:testapp/screens/movie/movie_screen.dart';
import '../../../components/section_with_button.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late HomeManagement homeData;
  int _current = 0;
  late bool isLoaded;

  @override
  void initState() {
    super.initState();
    homeData = Provider.of<HomeManagement>(context, listen: false);
    getMovies();
  }

  getMovies() async {
    if (mounted) {
      if (homeData.getTrendingMovie.isEmpty) {
        setState(() {
          isLoaded = false;
        });
        await homeData.fetchAllCategory();
      }
      if (mounted) {
        setState(() {
          isLoaded = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var homeModel = Provider.of<HomeManagement>(context, listen: false);

    final List<Widget> imageSliders = homeModel.getTrendingMovie
        .map(
          (item) => GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MovieScreen(
                          movie: item,
                        )),
              );
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              width: 1000,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(
                    "https://image.tmdb.org/t/p/original${item.backdropPath}",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(10)),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Center(
                          child: Text(
                            item.title,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ))
                  ]) /* add child content here */,
            ),
          ),
        )
        .toList();

    return Visibility(
      visible: isLoaded,
      replacement: const Center(child: CircularProgressIndicator()),
      child: (SingleChildScrollView(
        child: Column(children: [
          SectionWithButton(
            title: 'Top Trending',
            seeAll: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DiscoverScreen(
                          title: 'Top Trending',
                          param: 'trending',
                        )),
              );
            },
          ),
          Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                    autoPlay: false,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
                items: imageSliders,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    homeModel.getTrendingMovie.asMap().entries.map((entry) {
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black)
                            .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                  );
                }).toList(),
              ),
            ],
          ),
          const SectionNavigate(
            title: 'Action',
            genres: '28',
          ),
          MovieRow(movieType: homeModel.getActionMovie),
          const SectionNavigate(
            title: 'Animation',
            genres: '16',
          ),
          MovieRow(movieType: homeModel.getAnimationMovie),
          const SectionNavigate(
            title: 'Honor',
            genres: '27',
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: kDefaultPadding),
            child: MovieRow(movieType: homeModel.getTvShow),
          ),
        ]),
      )),
    );
  }
}

class SectionNavigate extends StatelessWidget {
  const SectionNavigate({
    Key? key,
    required this.title,
    required this.genres,
  }) : super(key: key);

  final String title, genres;

  @override
  Widget build(BuildContext context) {
    return SectionWithButton(
        title: title,
        seeAll: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DiscoverScreen(
                      title: title,
                      genres: genres,
                    )),
          );
        });
  }
}
