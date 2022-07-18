import 'package:flutter/material.dart';
import 'package:testapp/constans.dart';
import 'package:testapp/model/movie.dart';
import 'package:testapp/screens/movie/movie_screen.dart';

class MovieList extends StatelessWidget {
  const MovieList({
    Key? key,
    required this.isLoaded,
    required this.movieData,
  }) : super(key: key);

  final bool isLoaded;
  final List<Movie>? movieData;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoaded,
      // ignore: sort_child_properties_last
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
            itemCount: movieData?.length,
            itemBuilder: (BuildContext context, int index) {
              return MovieItem(
                  movie: movieData?[index],
                  image: movieData?[index].posterPath,
                  title: movieData?[index].originalTitle,
                  date: movieData?[index].releaseDate.toString(),
                  rate: movieData?[index].voteAverage.toString());
              // return Text('cc');
            }),
      ),
      replacement: const Center(child: CircularProgressIndicator()),
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
    required this.movie,
  }) : super(key: key);

  final String? image, title, date, rate;
  final Movie? movie;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieScreen(
                      movie: movie!,
                    )),
          );
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
