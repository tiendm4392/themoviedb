import 'package:flutter/foundation.dart';
import 'package:testapp/model/movie.dart';
import 'package:testapp/model/movie_list.dart';
import 'package:testapp/network/network_request.dart';

class MoviesManagement extends ChangeNotifier {
  // late MoviesManagement _movieList;

  final MovieList _movie =
      MovieList(totalPages: 1, results: [], page: 1, totalResults: 1);

  // MoviesManagement get movieList => _movieList;

  // set moviesList(MoviesManagement newMovies) {
  //   _movieList = newMovies;
  //   notifyListeners();
  // }

  List<Movie> get movies => _movie.results;

  int get currentPage => _movie.page;

  void loadMore(List<Movie> movie) {
    _movie.results.addAll(movie);

    notifyListeners();
  }

  getMovieListData({bool reset = false}) async {
    _movie.page = reset ? _movie.page : _movie.page + 1;
    final result = (await NetworkRequest.fetchMoviesData(page: _movie.page)!);
    _movie.totalPages = result.totalPages;
    _movie.page = result.page;
    _movie.totalResults = result.totalResults;
    _movie.results.addAll(result.results);
    notifyListeners();
  }
}
