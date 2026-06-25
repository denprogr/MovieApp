import 'dart:async';

class FavoriteBloc {
  // 1. Data Asli (State)
  final Set<int> _favoriteMovies = <int>{};

  // 2. Pipa Stream (Controller) - 'broadcast' agar bisa didengar oleh banyak halaman sekaligus
  final _favoriteController = StreamController<Set<int>>.broadcast();

  // 3. Pintu Keluar (Stream) - UI akan mendengarkan ini lewat StreamBuilder
  Stream<Set<int>> get favoriteStream => _favoriteController.stream;

  // 4. Fungsi / Event (Masukan dari UI)
  void toggleFavorite(int index) {
    if (_favoriteMovies.contains(index)) {
      _favoriteMovies.remove(index);
    } else {
      _favoriteMovies.add(index);
    }
    // Kirim data terbaru ke dalam pipa Stream
    _favoriteController.sink.add(_favoriteMovies);
  }

  // Menutup pipa jika aplikasi dimatikan (mencegah memory leak)
  void dispose() {
    _favoriteController.close();
  }
}

// Global instance (Untuk mempermudah pemanggilan BLoC di berbagai halaman)
final favoriteBloc = FavoriteBloc();