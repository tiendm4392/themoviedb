import 'dart:convert';

Movie movieFromJson(String str) => Movie.fromJson(json.decode(str));
String movieToJson(Movie data) => json.encode(data.toJson());

class Movie {
  Movie({
    required this.adult,
    required this.backdropPath,
    required this.id,
    required this.title,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    // required this.genreIds,
    required this.popularity,
    required this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    required this.name,
    required this.originalName,
    required this.firstAirDate,
    required this.originCountry,
  });

  bool adult;
  String backdropPath;
  int id;
  String title;
  String originalLanguage;
  String originalTitle;
  String overview;
  String posterPath;
  String mediaType;
  // List<int> genreIds;
  double popularity;
  String? releaseDate;
  bool video;
  double voteAverage;
  int voteCount;
  String name;
  String originalName;
  String? firstAirDate;
  String? originCountry;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        adult: json["adult"],
        backdropPath: json["backdrop_path"] ?? '',
        id: json["id"],
        title: json["title"] ?? '',
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"] ?? '',
        overview: json["overview"],
        posterPath: json["poster_path"] ?? '',
        mediaType: json["media_type"] ?? '',
        // genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        popularity: json["popularity"].toDouble(),
        releaseDate: json["release_date"] ?? '',
        video: json["video"] ?? false,
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
        name: json["name"] ?? '',
        originalName: json["original_name"] ?? '',
        firstAirDate: json["first_air_date"] ?? '',
        originCountry: json["origin_country"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "id": id,
        "title": title,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "poster_path": posterPath,
        "media_type": mediaType,
        // "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "popularity": popularity,
        "release_date": releaseDate,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "name": name,
        "original_name": originalName,
        "first_air_date": firstAirDate ?? '',
        "origin_country": originCountry,
      };
}
