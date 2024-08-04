import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../models/movie.dart';
import '../widgets/movie_poster.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  final List<Movie> movies = [
    Movie(
      id: 1,
      title: "The Shawshank Redemption",
      imageUrl:
          "https://scpc.com.vn/wp-content/uploads/2023/05/Lat-mat-6.2.jpg",
      year: 1994,
    ),
    Movie(
      id: 2,
      title: "The Godfather",
      imageUrl:
          "https://scpc.com.vn/wp-content/uploads/2023/05/Lat-mat-6.2.jpg",
      year: 1972,
    ),
    Movie(
      id: 3,
      title: "The Dark Knight",
      imageUrl:
          "https://scpc.com.vn/wp-content/uploads/2023/05/Lat-mat-6.2.jpg",
      year: 2008,
    ),
    Movie(
      id: 4,
      title: "12 Angry",
      imageUrl:
          "https://scpc.com.vn/wp-content/uploads/2023/05/Lat-mat-6.2.jpg",
      year: 1957,
    )
  ];

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: colorPrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "Movies",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.movies.map((movie) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal:
                              8.0), // Adjust the horizontal padding as needed
                      child: MoviePoster(movie: movie),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
