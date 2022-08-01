import 'package:flutter/foundation.dart';
import 'package:testapp/model/movie.dart';
import 'package:testapp/network/network_request.dart';

class ListMovieManagement extends ChangeNotifier {
  List<Movie> _trendingMovie = [];
  List<Movie> _actionMovie = [];
  List<Movie> _animationMovie = [];
  List<Movie> _tvShow = [];
  List<Movie> _favorite = [];
  List<int> _favoriteIds = [];

  List<Movie> get getTrendingMovie => _trendingMovie;
  List<Movie> get getActionMovie => _actionMovie;
  List<Movie> get getAnimationMovie => _animationMovie;
  List<Movie> get getTvShow => _tvShow;
  List<Movie> get getFavorite => _favorite;
  List<int> get getFavoriteIds => _favoriteIds;

  Future<void> fetchAllCategory() async {
    final trending = (await NetworkRequest.getMovies())!;
    final action = (await NetworkRequest.getMovies(genres: "28"))!;
    final animation = (await NetworkRequest.getMovies(genres: "16"))!;
    final tvShow = (await NetworkRequest.getMovies(genres: "27"))!;
    _trendingMovie = [...trending].sublist(0, 5);
    _actionMovie = [...action].sublist(0, 10);
    _animationMovie = [...animation].sublist(0, 10);
    _tvShow = [...tvShow].sublist(0, 10);
    notifyListeners();
  }

  fetchBookmark({required List<int> ids}) async {
    List<Movie> data = [];
    for (var i = 0; i < ids.length; i++) {
      final result = (await NetworkRequest.fetchMovieData(id: ids[i]))!;
      data.add(result);
    }
    _favoriteIds = [...ids];
    _favorite = data;
    notifyListeners();
  }

  resetBookmark() {
    _favoriteIds = [];
    _favorite = [];
    notifyListeners();
  }
}
