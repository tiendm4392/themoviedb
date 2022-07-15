import 'package:flutter/material.dart';
import 'package:testapp/constans.dart';
import 'package:testapp/model/movie.dart';
import 'package:testapp/network/network_request.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Movie>? movieData;

  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getMovies();
  }

  getMovies() async {
    movieData = await NetworkRequest.getMovies(param: "discover");
    if (movieData != null) {
      if (mounted) {
        setState(() {
          isLoaded = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Visibility(
        visible: isLoaded,
        // ignore: sort_child_properties_last
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.builder(
              itemCount: movieData?.length,
              itemBuilder: (BuildContext context, int index) {
                return MovieItem(
                    image: movieData?[index].posterPath,
                    title: movieData?[index].originalTitle,
                    date: movieData?[index].releaseDate.toString(),
                    rate: movieData?[index].voteAverage.toString());
                // return Text('cc');
              }),
        ),
        replacement: const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0.4,
      backgroundColor: Colors.white,
      title: const Text(
        "Discover",
        style: headerText,
      ),
    );
  }
}

class MovieItem extends StatelessWidget {
  const MovieItem({
    Key? key,
    required this.image,
    required this.title,
    required this.date,
    required this.rate,
  }) : super(key: key);

  final String? image, title, date, rate;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: GestureDetector(
        onTap: () {
          print('movie');
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                'https://image.tmdb.org/t/p/original/$image',
                width: 95,
                height: 120,
                fit: BoxFit.cover,
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
                  Text(date!.substring(0, 10)),
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
                  color: kLightBlueColor,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Icon(
                    Icons.star,
                    color: kLightBlueColor,
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
