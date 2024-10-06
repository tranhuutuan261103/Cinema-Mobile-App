import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../../common/constants/colors.dart';
import '../../../../common/models/movie.dart';
import '../../../../common/widgets/movie_poster.dart';
import '../../../../common/widgets/not_found_container.dart';
import '../../../../common/services/movie_service.dart';
import '../../../../common/routes/routes.dart';

class HomePage extends StatefulWidget {
  // ignore: use_super_parameters
  const HomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  late Future<List<Movie>> _moviesFuture;

  @override
  void initState() {
    super.initState();
    _moviesFuture = MovieService().getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "Phim hay đang chiếu",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FutureBuilder<List<Movie>>(
                future: _moviesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Show a loading indicator while waiting for the movies have width = 100% of screen width
                    return const SizedBox(
                      width: double.infinity,
                      child: LinearProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return NotFoundContainer(
                      message: "Please try again later.",
                      subMessage: snapshot.error.toString(),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const NotFoundContainer(
                      message: "No movies found.",
                      subMessage: "Please try again later.",
                    );
                  } else {
                    final movies = snapshot.data!;
                    return CarouselSlider.builder(
                      itemCount: movies.length,
                      itemBuilder: (context, index, realIndex) {
                        final movie = movies[index];
                        return MoviePoster(
                          movie: movie,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.movieDetail,
                              arguments: movie,
                            );
                          },
                        );
                      },
                      options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 1 / 1.2,
                        enlargeCenterPage: true,
                        viewportFraction : 0.6,
                      ),
                    );
                  }
                },
              ),
              const Text(
                "Phim sắp chiếu",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
