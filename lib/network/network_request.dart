import 'package:http/http.dart' as http;
import 'package:testapp/model/movie.dart';
import 'package:testapp/model/movie_detail.dart';
import 'package:testapp/model/movie_list.dart';

class NetworkRequest {
  static const String url = 'https://api.themoviedb.org/3/';
  static const String token = '?api_key=ee8aef302c3055bfbf301250a156a772';

  static Future<List<Movie>?> getMovies(
      {String? param = 'discover',
      String? time = '',
      String? genres = '',
      int? page = 1}) async {
    var client = http.Client();
    var urlString = Uri.parse(
        '$url$param/movie/$time$token&with_genres=$genres&page=$page&include_adult=false');
    var response = await client.get(urlString);

    if (response.statusCode == 200) {
      var json = response.body;
      var data = movieListFromJson(json);
      return data.results;
    } else {
      throw ('error');
    }
  }

  static Future<MovieList>? fetchMoviesData(
      {String? param = 'discover',
      String? time = '',
      String? genres = '',
      int? page = 1}) async {
    var client = http.Client();
    var urlString = Uri.parse(
        '$url$param/movie/$time$token&with_genres=$genres&page=$page&include_adult=false');
    var response = await client.get(urlString);

    if (response.statusCode == 200) {
      var json = response.body;
      var data = movieListFromJson(json);
      return data;
    } else {
      throw ('error');
    }
  }

  static Future<MovieDetail?> fetchMovieData({
    required int id,
  }) async {
    var client = http.Client();
    var urlString = Uri.parse('$url/movie/$id$token');
    var response = await client.get(urlString);

    if (response.statusCode == 200) {
      var json = response.body;
      var data = movieDetailFromJson(json);
      return data;
    } else {
      throw ('error');
    }
  }

  static Future<MovieList>? searchMovies(
      {String? query = '', int? page = 1}) async {
    var client = http.Client();
    var urlString = Uri.parse(
        '${url}search/movie$token&query=$query&page=$page&include_adult=false');
    var response = await client.get(urlString);
    if (response.statusCode == 200) {
      var json = response.body;
      var data = movieListFromJson(json);
      return data;
    } else {
      throw ('error');
    }
  }
}
