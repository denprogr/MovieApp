import 'package:hive_flutter/hive_flutter.dart';
import '../models/movie.dart';

/// Service local storage pakai Hive.
/// Dipakai buat 2 hal:
/// 1. Cache daftar film -> fallback kalau lagi offline
/// 2. Nyimpen daftar favorit -> ditampilin di fav_page pakai StreamBuilder
///    (Hive punya box.watch() yang return Stream<BoxEvent>, jadi pas banget)
class LocalStorageService {
  static const String movieBoxName = 'movies_cache_box';
  static const String favBoxName = 'favorites_box';

  /// Panggil ini sekali di main() sebelum runApp()
  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(movieBoxName);
    await Hive.openBox(favBoxName);
  }

  Box get _movieBox => Hive.box(movieBoxName);
  Box get _favBox => Hive.box(favBoxName);

  // ---------- Cache film (fallback offline) ----------

  Future<void> cacheMovies(List<Movie> movies) async {
    await _movieBox.clear();
    final Map<dynamic, dynamic> entries = {
      for (final m in movies) m.id: m.toMap(),
    };
    await _movieBox.putAll(entries);
  }

  List<Movie> getCachedMovies() {
    return _movieBox.values
        .map((e) => Movie.fromMap(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  bool get hasCachedMovies => _movieBox.isNotEmpty;

  // ---------- Favorite ----------

  Future<void> toggleFavorite(Movie movie) async {
    if (_favBox.containsKey(movie.id)) {
      await _favBox.delete(movie.id);
    } else {
      await _favBox.put(movie.id, movie.toMap());
    }
  }

  bool isFavorite(int movieId) => _favBox.containsKey(movieId);

  List<Movie> getFavorites() {
    return _favBox.values
        .map((e) => Movie.fromMap(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  /// Stream perubahan box favorite -> dikonsumsi StreamBuilder di fav_page
  Stream<BoxEvent> watchFavorites() => _favBox.watch();
}
