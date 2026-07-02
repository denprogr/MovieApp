import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

/// Service buat komunikasi ke TMDB API.
/// Daftar API key gratis di https://www.themoviedb.org/settings/api
class ApiService {
  static const String _apiKey = '9c6bad8b262ad7de1edea575afcb92b9';  
  static const String _baseUrl = 'https://api.themoviedb.org/3';

  /// Ambil daftar film populer (buat movie_list_page)
  Future<List<Movie>> fetchPopularMovies({int page = 1}) async {
    final uri = Uri.parse(
      '$_baseUrl/movie/popular?api_key=$_apiKey&language=id-ID&page=$page',
    );

    final response = await http.get(uri).timeout(
          const Duration(seconds: 10),
        );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final results = data['results'] as List;
      return results
          .map((item) => Movie.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Gagal mengambil data film (${response.statusCode})');
    }
  }

  /// Ambil detail film by id (buat movie_detail_page, dipakai di FutureBuilder)
  Future<Movie> fetchMovieDetail(int movieId) async {
    final uri = Uri.parse(
      '$_baseUrl/movie/$movieId?api_key=$_apiKey&language=id-ID',
    );

    final response = await http.get(uri).timeout(
          const Duration(seconds: 10),
        );

    if (response.statusCode == 200) {
      return Movie.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Gagal mengambil detail film (${response.statusCode})');
    }
  }
}
