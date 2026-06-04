import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Catalog',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MovieListPage(),
    );
  }
}

// 1. PINDAHKAN ARRAY DATA KE LUAR BUILD METHOD
// Agar data lebih fleksibel dan bisa ditambah/hapus dengan mudah
final List<Map<String, String>> movieData = [
  {'title': 'Inception', 'year': '2010-07-15', 'rating': '8.4'},
  {'title': 'Interstellar', 'year': '2014-11-07', 'rating': '8.6'},
  {'title': 'Tenet', 'year': '2020-08-22', 'rating': '7.3'},
  {'title': 'The Dark Knight Rises', 'year': '2012-07-16', 'rating': '7.8'},
  {'title': 'Avatar: The Way of Water', 'year': '2022-12-14', 'rating': '7.6'},
  {'title': 'Oppenheimer', 'year': '2023-07-21', 'rating': '8.9'}, // Contoh tambah data baru
];

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
      ),
      // 2. LISTVIEW.BUILDER YANG FLEKSIBEL
      // Dia akan otomatis mengikuti panjang array 'movieData'
      body: ListView.builder(
        itemCount: movieData.length,
        itemBuilder: (context, index) {
          final movie = movieData[index]; // Mengambil item berdasarkan index

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Visual Poster
                Container(
                  width: 90,
                  height: 130,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        )
                      ]
                  ),
                  child: Icon(Icons.movie_filter, color: Colors.grey[400], size: 40),
                ),
                const SizedBox(width: 16),
                // Detail Informasi
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
                      // Baris Rating
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              movie['rating']!,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}