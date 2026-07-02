import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';

class MovieDetailPage extends StatefulWidget {
  final Movie movie; // data awal dari list (biar detail bisa langsung nampilin sesuatu)

  const MovieDetailPage({super.key, required this.movie});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final ApiService _apiService = ApiService();
  final LocalStorageService _localStorageService = LocalStorageService();
  late Future<Movie> _movieDetailFuture;
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    // FutureBuilder butuh Future yang gak dibuat ulang tiap rebuild,
    // makanya di-assign sekali di initState, bukan di build().
    _movieDetailFuture = _apiService.fetchMovieDetail(widget.movie.id);
    _isFavorite = _localStorageService.isFavorite(widget.movie.id);
  }

  void _toggleFavorite(Movie movie) async {
    await _localStorageService.toggleFavorite(movie);
    setState(() {
      _isFavorite = _localStorageService.isFavorite(movie.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Movie>(
        future: _movieDetailFuture,
        builder: (context, snapshot) {
          // Selagi nunggu detail dari API, tetep tampilin data dasar dari list
          final movie = snapshot.data ?? widget.movie;
          final isLoadingDetail =
              snapshot.connectionState == ConnectionState.waiting;
          final hasDetailError = snapshot.hasError;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 260,
                pinned: true,
                actions: [
                  IconButton(
                    icon: Icon(
                      _isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: _isFavorite ? Colors.red : null,
                    ),
                    onPressed: () => _toggleFavorite(movie),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: CachedNetworkImage(
                    imageUrl: movie.backdropUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 18),
                          const SizedBox(width: 4),
                          Text(movie.voteAverage.toStringAsFixed(1)),
                          const SizedBox(width: 16),
                          Text(movie.releaseDate),
                          if (movie.runtime != null) ...[
                            const SizedBox(width: 16),
                            Text('${movie.runtime} menit'),
                          ],
                        ],
                      ),
                      const SizedBox(height: 12),

                      if (isLoadingDetail)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 14,
                                height: 14,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                              SizedBox(width: 8),
                              Text('Memuat detail lengkap...'),
                            ],
                          ),
                        ),

                      if (hasDetailError)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'Gagal memuat detail tambahan (cek koneksi internet).',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),

                      if (movie.genres != null && movie.genres!.isNotEmpty)
                        Wrap(
                          spacing: 8,
                          children: movie.genres!
                              .map((g) => Chip(label: Text(g)))
                              .toList(),
                        ),

                      const SizedBox(height: 16),
                      const Text(
                        'Sinopsis',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        movie.overview.isEmpty
                            ? 'Sinopsis tidak tersedia.'
                            : movie.overview,
                        style: const TextStyle(height: 1.4),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
