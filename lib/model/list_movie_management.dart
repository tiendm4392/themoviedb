import 'package:flutter/foundation.dart';
import 'package:testapp/model/movie.dart';
import 'package:testapp/model/movie_detail.dart';
import 'package:testapp/network/network_request.dart';

class ListMovieManagement extends ChangeNotifier {
  
  List<Movie> _trendingMovie = [];
  List<Movie> _actionMovie = [];
  List<Movie> _animationMovie = [];
  List<Movie> _tvShow = [];
  final List<MovieDetail> _favorite = [];

  List<Movie> get getTrendingMovie => _trendingMovie;
  List<Movie> get getActionMovie => _actionMovie;
  List<Movie> get getAnimationMovie => _animationMovie;
  List<Movie> get getTvShow => _tvShow;
  List<MovieDetail> get getFavorite => _favorite;

  Future<void> fetchAllCategory() async {
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

  Future<void> fetchBookmark({required List<int> ids}) async {
    ids.map((res) async {
      _favorite.add((await NetworkRequest.fetchMovieData(id: res))!);
    });
    notifyListeners();
  }
}
