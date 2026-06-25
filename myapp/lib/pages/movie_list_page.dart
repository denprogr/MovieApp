import 'package:flutter/material.dart';

import '../../data/movie_data.dart';
import 'movie_detail_page.dart';
import 'fav_page.dart';
import '../bloc/fav_bloc.dart';

class MovieListPage extends StatelessWidget {
  const MovieListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Catalog', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          // STREAMBUILDER PADA TOMBOL FAVORITE DI APPBAR
          StreamBuilder<Set<int>>(
              stream: favoriteBloc.favoriteStream,
              initialData: const <int>{}, // Data awal kosong
              builder: (context, snapshot) {
                final favoriteMovies = snapshot.data!;

                return IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.red),
                  onPressed: () {
                    final List<Map<String, String>> favMoviesList = [];
                    for (int i = 0; i < movieData.length; i++) {
                      if (favoriteMovies.contains(i)) {
                        favMoviesList.add(movieData[i]);
                      }
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavoritePage(favoriteMovies: favMoviesList),
                      ),
                    );
                  },
                );
              }
          ),
          const SizedBox(width: 8),
        ],
      ),

      // FUTUREBUILDER UNTUK MENGAMBIL DATA FILM (Loading screen)
      body: FutureBuilder<List<Map<String, String>>>(
        future: fetchMovies(), // Memanggil fungsi jeda 2 detik tadi
        builder: (context, futureSnapshot) {
          // Jika masih menunggu (Loading)
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text("Mengambil data dari server...")
                  ],
                )
            );
          }

          // Jika data sukses didapat
          if (futureSnapshot.hasData) {
            final movies = futureSnapshot.data!;

            // BUNGKUS LISTVIEW DENGAN STREAMBUILDER UNTUK FITUR FAVORITE
            return StreamBuilder<Set<int>>(
                stream: favoriteBloc.favoriteStream,
                initialData: const <int>{},
                builder: (context, streamSnapshot) {
                  final favoriteMovies = streamSnapshot.data!;

                  return ListView.builder(
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      final isFavorite = favoriteMovies.contains(index);

                      return InkWell(
                        onTap: () {
                          // Tidak perlu async/await setState lagi! Cukup Pindah halaman.
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetailPage(movie: movie, index: index),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  movie['posterUrl']!,
                                  width: 90, height: 130, fit: BoxFit.cover,
                                  errorBuilder: (c, e, s) => Container(width: 90, height: 130, color: Colors.grey),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(movie['title']!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                    Text('Released: ${movie['year']}', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                                    const SizedBox(height: 12),
                                    Row(
                                      children: [
                                        const Icon(Icons.star, color: Colors.amber, size: 16),
                                        const SizedBox(width: 4),
                                        Text(movie['rating']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // TOMBOL FAVORITE YANG MENGIRIM EVENT KE BLoC
                              IconButton(
                                icon: Icon(
                                  isFavorite ? Icons.favorite : Icons.favorite_border,
                                  color: isFavorite ? Colors.red : Colors.grey,
                                ),
                                onPressed: () => favoriteBloc.toggleFavorite(index), // Panggil fungsi di BLoC
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
            );
          }

          // Jika terjadi error
          return const Center(child: Text("Gagal memuat data"));
        },
      ),
    );
  }
}