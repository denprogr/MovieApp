import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';
import 'movie_event.dart';
import 'movie_state.dart';

/// BLoC utama buat ngatur data film.
/// Alurnya:
/// 1. Cek koneksi internet
/// 2. Kalau ada internet -> hit API, kalau berhasil simpan ke cache lokal
/// 3. Kalau gak ada internet (atau API gagal) -> ambil dari cache lokal (Hive)
/// 4. Kalau cache juga kosong -> emit error
class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final ApiService apiService;
  final LocalStorageService localStorageService;

  MovieBloc({
    required this.apiService,
    required this.localStorageService,
  }) : super(MovieInitial()) {
    on<FetchMovies>(_onFetchMovies);
    on<RefreshMovies>(_onFetchMovies);
  }

  Future<void> _onFetchMovies(
    MovieEvent event,
    Emitter<MovieState> emit,
  ) async {
    emit(MovieLoading());

    final connectivityResult = await Connectivity().checkConnectivity();
    final hasInternet = connectivityResult != ConnectivityResult.none;

    if (hasInternet) {
      try {
        final movies = await apiService.fetchPopularMovies();
        await localStorageService.cacheMovies(movies);
        emit(MovieLoaded(movies: movies, isFromCache: false));
        return;
      } catch (_) {
        // API gagal walau ada internet -> coba fallback ke cache
      }
    }

    // Offline, atau API gagal
    if (localStorageService.hasCachedMovies) {
      final cached = localStorageService.getCachedMovies();
      emit(MovieLoaded(movies: cached, isFromCache: true));
    } else {
      emit(const MovieError(
        'Tidak ada koneksi internet dan belum ada data tersimpan.',
      ));
    }
  }
}
