final List<Map<String, String>> movieData = [
  {
    'title': 'Inception',
    'year': '2010-07-15',
    'rating': '8.4',
    'genre': 'Sci-Fi, Action',
    'synopsis': 'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.',
    'posterUrl': 'https://image.tmdb.org/t/p/w500/9gk7adHYeDvHkCSEqAvQNLV5Uge.jpg',
  },
  {
    'title': 'Interstellar',
    'year': '2014-11-07',
    'rating': '8.6',
    'genre': 'Sci-Fi, Adventure',
    'synopsis': 'A team of explorers travel through a wormhole in space in an attempt to ensure humanity\'s survival.',
    'posterUrl': 'https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg',
  },
  {
    'title': 'Tenet',
    'year': '2020-08-22',
    'rating': '7.3',
    'genre': 'Sci-Fi, Sci-Fi',
    'synopsis': 'Armed with only one word, Tenet, and fighting for the survival of the entire world, a Protagonist journeys through a twilight world of international espionage on a mission that will unfold in something beyond real time.',
    'posterUrl': 'https://image.tmdb.org/t/p/w500/k68nPLbIST6NP96JmTxmZijEvCA.jpg',
  },
  {
    'title': 'The Dark Knight Rises',
    'year': '2012-07-16',
    'rating': '7.8',
    'genre': 'Action, Drama',
    'synopsis': 'Eight years after the Joker\'s reign of anarchy, Batman, with the help of the enigmatic Catwoman, is forced from his exile to save Gotham City from the brutal guerrilla terrorist Bane.',
    'posterUrl': 'https://image.tmdb.org/t/p/w500/hr0L2aueqlP2BYUblTTjmtn0hw4.jpg',
  },
  {
    'title': 'Avatar: The Way of Water',
    'year': '2022-12-14',
    'rating': '7.6',
    'genre': 'Sci-Fi, Adventure',
    'synopsis': 'Jake Sully lives with his newfound family formed on the extraterrestrial moon of Pandora. Once a familiar threat returns to finish what was previously started, Jake must work with Neytiri and the army of the Na\'vi race to protect their home.',
    'posterUrl': 'https://image.tmdb.org/t/p/w500/t6HIqrHezINNdIEq11DiOqX14H.jpg',
  },
  {
    'title': 'Oppenheimer',
    'year': '2023-07-21',
    'rating': '8.9',
    'genre': 'Biography, Drama',
    'synopsis': 'The story of American scientist J. Robert Oppenheimer and his role in the development of the atomic bomb.',
    'posterUrl': 'https://image.tmdb.org/t/p/w500/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg',
  },
  {
    'title': 'Dune: Part Two',
    'year': '2024-03-01',
    'rating': '9.0',
    'genre': 'Sci-Fi, Adventure',
    'synopsis': 'Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.',
    'posterUrl': 'https://image.tmdb.org/t/p/w500/1pdfLvkbY9ohJlCjQH2TDpi72K.jpg',
  },
];

Future<List<Map<String, String>>> fetchMovies() async {
  // Simulasi loading jaringan selama 2 detik
  await Future.delayed(const Duration(seconds: 2));
  return movieData;
}