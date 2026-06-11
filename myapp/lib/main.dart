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

// DATA SOURCE UTAMA
final List<Map<String, String>> movieData = [
  {
    'title': 'Inception',
    'year': '2010-07-15',
    'rating': '8.4',
    'genre': 'Sci-Fi, Action',
    'synopsis':
        'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.',
    'posterUrl':
        'https://image.tmdb.org/t/p/w500/9gk7adHYeDvHkCSEqAvQNLV5Uge.jpg',
  },
  {
    'title': 'Interstellar',
    'year': '2014-11-07',
    'rating': '8.6',
    'genre': 'Sci-Fi, Adventure',
    'synopsis':
        'A team of explorers travel through a wormhole in space in an attempt to ensure humanity\'s survival.',
    'posterUrl':
        'https://image.tmdb.org/t/p/w500/9gk7adHYeDvHkCSEqAvQNLV5Uge.jpg',
  },
  {
    'title': 'Tenet',
    'year': '2020-08-22',
    'rating': '7.3',
    'genre': 'Sci-Fi, Sci-Fi',
    'synopsis':
        'Armed with only one word, Tenet, and fighting for the survival of the entire world, a Protagonist journeys through a twilight world of international espionage on a mission that will unfold in something beyond real time.',
    'posterUrl':
        'https://image.tmdb.org/t/p/w500/9gk7adHYeDvHkCSEqAvQNLV5Uge.jpg',
  },
  {
    'title': 'The Dark Knight Rises',
    'year': '2012-07-16',
    'rating': '7.8',
    'genre': 'Action, Drama',
    'synopsis':
        'Eight years after the Joker\'s reign of anarchy, Batman, with the help of the enigmatic Catwoman, is forced from his exile to save Gotham City from the brutal guerrilla terrorist Bane.',
    'posterUrl':
        'https://image.tmdb.org/t/p/w500/9gk7adHYeDvHkCSEqAvQNLV5Uge.jpg',
  },
  {
    'title': 'Avatar: The Way of Water',
    'year': '2022-12-14',
    'rating': '7.6',
    'genre': 'Sci-Fi, Adventure',
    'synopsis':
        'Jake Sully lives with his newfound family formed on the extraterrestrial moon of Pandora. Once a familiar threat returns to finish what was previously started, Jake must work with Neytiri and the army of the Na\'vi race to protect their home.',
    'posterUrl':
        'https://image.tmdb.org/t/p/w500/9gk7adHYeDvHkCSEqAvQNLV5Uge.jpg',
  },
  {
    'title': 'Oppenheimer',
    'year': '2023-07-21',
    'rating': '8.9',
    'genre': 'Biography, Drama',
    'synopsis':
        'The story of American scientist J. Robert Oppenheimer and his role in the development of the atomic bomb.',
    'posterUrl':
        'https://image.tmdb.org/t/p/w500/9gk7adHYeDvHkCSEqAvQNLV5Uge.jpg',
  },
  {
    'title': 'Dune: Part Two',
    'year': '2024-03-01',
    'rating': '9.0',
    'genre': 'Sci-Fi, Adventure',
    'synopsis':
        'Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.',
    'posterUrl':
        'https://image.tmdb.org/t/p/w500/9gk7adHYeDvHkCSEqAvQNLV5Uge.jpg',
  },
];

//HALAMAN LIST FILM (Ubah ke StatefulWidget untuk Fitur Favorit)
class MovieListPage extends StatefulWidget {
  const MovieListPage({super.key});

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  // Set untuk menyimpan index film yang difavoritkan (biar tidak duplikat)
  final Set<int> favoriteMovies = <int>{};

  // Fungsi toggle favorit yang nanti bisa dipasang di List maupun Detail
  void toggleFavorite(int index) {
    setState(() {
      if (favoriteMovies.contains(index)) {
        favoriteMovies.remove(index);
      } else {
        favoriteMovies.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Movie Catalog',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: movieData.length,
        itemBuilder: (context, index) {
          final movie = movieData[index];
          final isFavorite = favoriteMovies.contains(index);

          return InkWell(
            // 1. NAVIGASI: Pindah ke Halaman Detail saat Item di-klik
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailPage(
                    movie: movie,
                    index: index,
                    isFavorite: isFavorite,
                    onFavoriteToggle: toggleFavorite,
                  ),
                ),
              );
              // Memicu refresh halaman utama ketika user kembali dari halaman detail
              setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Poster
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    // Mempertahankan sudut melengkung
                    child: Image.network(
                      movie['posterUrl']!,
                      width: 90,
                      height: 130,
                      fit: BoxFit.cover,
                      //Agar gambar tidak gepeng, melainkan memenuhi kotak
                      // Error Builder: Jaga-jaga kalau internet mati atau link gambar rusak
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 90,
                          height: 130,
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.broken_image,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Informasi Film
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Text(
                          movie['title']!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Released: ${movie['year']}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.amber.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    movie['rating']!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // 2. FITUR FAVORITE: Tombol Hati di Halaman List
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: () => toggleFavorite(index),
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

//HALAMAN DETAIL FILM
class MovieDetailPage extends StatefulWidget {
  final Map<String, String> movie;
  final int index;
  final bool isFavorite;
  final Function(int) onFavoriteToggle;

  const MovieDetailPage({
    super.key,
    required this.movie,
    required this.index,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late bool _isFavoriteLocal;

  @override
  void initState() {
    super.initState();
    _isFavoriteLocal = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie['title']!),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          // 2. FITUR FAVORITE: Tombol Hati di Halaman Detail
          IconButton(
            icon: Icon(
              _isFavoriteLocal ? Icons.favorite : Icons.favorite_border,
              color: _isFavoriteLocal ? Colors.red : Colors.black,
            ),
            onPressed: () {
              setState(() {
                _isFavoriteLocal = !_isFavoriteLocal;
              });
              widget.onFavoriteToggle(
                widget.index,
              ); // Kirim perubahan ke halaman utama
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Poster Besar di Detail
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.movie['posterUrl']!,
                width: 160,
                height: 240,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 160,
                    height: 240,
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.broken_image,
                      color: Colors.grey,
                      size: 50,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            // Judul Film
            Text(
              widget.movie['title']!,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Genre & Info Rilis
            Row(
              children: [
                Icon(Icons.movie_creation, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 6),
                Text(
                  widget.movie['genre']!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 16),
                Icon(Icons.calendar_month, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 6),
                Text(
                  widget.movie['year']!,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Rating
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                Text(
                  '${widget.movie['rating']} / 10',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: 32, thickness: 1),
            // Sinopsis
            const Text(
              'Synopsis',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              widget.movie['synopsis']!,
              style: const TextStyle(
                fontSize: 15,
                height: 1.5,
                color: Colors.black87,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
