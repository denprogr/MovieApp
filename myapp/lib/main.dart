import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Data dummy untuk katalog film
    final List<Map<String, String>> movies = [
      {'title': 'Inception', 'year': '2010-07-15', 'rating': '8.4'},
      {'title': 'Interstellar', 'year': '2014-11-07', 'rating': '8.6'},
      {'title': 'Tenet', 'year': '2020-08-22', 'rating': '7.3'},
      {'title': 'The Dark Knight Rises', 'year': '2012-07-16', 'rating': '7.8'},
      {'title': 'Avatar: The Way of Water', 'year': '2022-12-14', 'rating': '7.6'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Catalog', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      // 1. SCROLLING WIDGET: ListView.builder (Sangat efisien untuk daftar panjang)
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      // 2. LAYOUT WIDGET: Row (Menyusun Poster di kiri, Teks di kanan)
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      // 3. PAINTING WIDGET: Container dengan Decoration (Simulasi Poster Film)
          Container(
          width: 80,
          height: 120,
          decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(4),
      ),
            child: Icon(Icons.movie_creation_outlined, color: Colors.grey[600], size: 40),
          ),
          const SizedBox(width: 16),
          // 4. LAYOUT WIDGET: Expanded & Column (Menyusun teks secara vertikal)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                // 5. TEXT WIDGET: Menggunakan berbagai TextStyle
                Text(
                  movies[index]['title']!,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  movies[index]['year']!,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      movies[index]['rating']!,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ],
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

