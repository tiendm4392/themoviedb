import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:testapp/model/movie.dart';
import 'package:testapp/model/movie_list.dart';

class NetworkRequest {
  static const String url = 'https://api.themoviedb.org/3/';
  static const String token = '?api_key=ee8aef302c3055bfbf301250a156a772';

  static Future<List<Movie>?> getMovies({String param = '', String? time = '', String? genres = ''}) async {
    var client = http.Client();
    var urlString = Uri.parse('$url$param/movie/$time$token&with_genres=$genres');
    var response = await client.get(urlString);

    if (response.statusCode == 200) {
      var json = response.body;
      var data = movieListFromJson(json);
      return data.results;
    } else {
      throw ('error');
    }
  }
}
