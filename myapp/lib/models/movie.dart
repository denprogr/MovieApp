import 'package:equatable/equatable.dart';

/// Model Movie.
/// - fromJson()  -> dipakai buat parsing response dari TMDB API
/// - fromMap()/toMap() -> dipakai buat nyimpen & baca dari Hive (local storage)
class Movie extends Equatable {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final double voteAverage;
  final String releaseDate;
  final int? runtime; // cuma keisi kalau dari endpoint detail
  final List<String>? genres; // cuma keisi kalau dari endpoint detail

  const Movie({
    required this.id,
    required this.title,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    required this.voteAverage,
    required this.releaseDate,
    this.runtime,
    this.genres,
  });

  String get posterUrl => posterPath != null
      ? 'https://image.tmdb.org/t/p/w500$posterPath'
      : 'https://placehold.co/500x750?text=No+Image';

  String get backdropUrl => backdropPath != null
      ? 'https://image.tmdb.org/t/p/w780$backdropPath'
      : posterUrl;

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] as int,
      title: json['title'] ?? 'Tanpa Judul',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      releaseDate: json['release_date'] ?? '-',
      runtime: json['runtime'],
      genres: json['genres'] != null
          ? List<String>.from(
              (json['genres'] as List).map((g) => g['name'].toString()))
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'vote_average': voteAverage,
      'release_date': releaseDate,
      'runtime': runtime,
      'genres': genres,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] as int,
      title: map['title'] ?? 'Tanpa Judul',
      overview: map['overview'] ?? '',
      posterPath: map['poster_path'],
      backdropPath: map['backdrop_path'],
      voteAverage: (map['vote_average'] ?? 0).toDouble(),
      releaseDate: map['release_date'] ?? '-',
      runtime: map['runtime'],
      genres: map['genres'] != null ? List<String>.from(map['genres']) : null,
    );
  }

  @override
  List<Object?> get props =>
      [id, title, overview, posterPath, voteAverage, releaseDate];
}
