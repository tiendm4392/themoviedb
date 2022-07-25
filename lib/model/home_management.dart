import 'package:flutter/foundation.dart';
import 'package:testapp/model/movie.dart';
import 'package:testapp/network/network_request.dart';

class HomeManagement extends ChangeNotifier {
  List<Movie> _trendingMovie = [];
  List<Movie> _actionMovie = [];
  List<Movie> _animationMovie = [];
  List<Movie> _tvShow = [];

  List<Movie> get getTrendingMovie => _trendingMovie;
  List<Movie> get getActionMovie => _actionMovie;
  List<Movie> get getAnimationMovie => _animationMovie;
  List<Movie> get getTvShow => _tvShow;

  fetchAllCategory() async {
    final trending =
        (await NetworkRequest.getMovies(param: "trending", time: "day"))!;
    final action = (await NetworkRequest.getMovies(genres: "28"))!;
    final animation = (await NetworkRequest.getMovies(genres: "16"))!;
    final tvShow = (await NetworkRequest.getMovies(genres: "27"))!;
    _trendingMovie = [...trending].sublist(0, 5);
    _actionMovie = [...action].sublist(0, 11);
    _animationMovie = [...animation].sublist(0, 11);
    _tvShow = [...tvShow].sublist(0, 11);
    notifyListeners();
  }
}
