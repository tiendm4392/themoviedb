import 'package:flutter/foundation.dart';
import 'package:testapp/model/movie.dart';
import 'package:testapp/model/movie_list.dart';
import 'package:testapp/network/network_request.dart';

class MoviesManagement extends ChangeNotifier {
  final MovieList _movie =
      MovieList(totalPages: 1, results: [], page: 1, totalResults: 1);
  String _keyWord = "";

  List<Movie> get movies => _movie.results;
  int get currentPage => _movie.page;
  String get currentKeyWord => _keyWord;

  getMovieListData({bool reset = false}) async {
    _keyWord = '';
    var currentPage = reset ? 1 : _movie.page + 1;
    final result = (await NetworkRequest.fetchMoviesData(page: currentPage)!);
    _movie.totalPages = result.totalPages;
    _movie.page = result.page;
    _movie.totalResults = result.totalResults;
    _movie.results =
        reset ? result.results : [..._movie.results, ...result.results];
    notifyListeners();
  }

  searchMovieListData({bool reset = false, String? query = ''}) async {
    _keyWord = query!;
    var currentPage = reset ? 1 : _movie.page + 1;
    final result =
        (await NetworkRequest.searchMovies(page: currentPage, query: query)!);
    _movie.totalPages = result.totalPages;
    _movie.page = result.page;
    _movie.totalResults = result.totalResults;
    _movie.results =
        reset ? result.results : [..._movie.results, ...result.results];
    notifyListeners();
  }
}
