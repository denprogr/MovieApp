import 'package:flutter/material.dart';

import 'movie_detail_page.dart';
import '../data/movie_data.dart';

class FavoritePage extends StatelessWidget {
  final List<Map<String, String>> favoriteMovies;

  const FavoritePage({super.key, required this.favoriteMovies});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorites', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: favoriteMovies.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 100, color: Colors.grey[300]),
            const SizedBox(height: 16),
            const Text(
              'No Favorites Yet',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Film yang kamu sukai akan muncul di sini.',
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: favoriteMovies.length,
        itemBuilder: (context, index) {
          final movie = favoriteMovies[index];

          // 2. CARI INDEX ASLI FILM DI DALAM MOVIEDATA AGAR SINKRON DENGAN BLOC
          final originalIndex = movieData.indexOf(movie);

          // 3. BUNGKUS DENGAN INKWELL AGAR BISA DI-KLIK
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailPage(
                    movie: movie,
                    index: originalIndex, // Kirim index asli
                  ),
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
                      width: 90,
                      height: 130,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 90, height: 130, color: Colors.grey[300],
                          child: const Icon(Icons.broken_image, color: Colors.grey),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Text(
                          movie['title']!,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Released: ${movie['year']}',
                          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              movie['rating']!,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}