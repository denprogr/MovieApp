import 'package:flutter/material.dart';
import '../bloc/fav_bloc.dart';

class MovieDetailPage extends StatelessWidget {
  final Map<String, String> movie;
  final int index;

  const MovieDetailPage({
    super.key,
    required this.movie,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie['title']!),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          // MENDENGARKAN STREAM SECARA MANDIRI
          StreamBuilder<Set<int>>(
              stream: favoriteBloc.favoriteStream,
              initialData: const <int>{},
              builder: (context, snapshot) {
                final isFavorite = snapshot.data!.contains(index);

                return IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.black,
                  ),
                  onPressed: () {
                    // Kirim event ke BLoC
                    favoriteBloc.toggleFavorite(index);
                  },
                );
              }
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                movie['posterUrl']!,
                width: 160, height: 240, fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(width: 160, height: 240, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 24),
            Text(movie['title']!, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('${movie['genre']} • ${movie['year']}', style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                Text('${movie['rating']} / 10', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            const Divider(height: 32, thickness: 1),
            const Text('Synopsis', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(movie['synopsis']!, style: const TextStyle(fontSize: 15, height: 1.5), textAlign: TextAlign.justify),
          ],
        ),
      ),
    );
  }
}