import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieTrailer extends StatefulWidget {
  final String trailerUrl;

  const MovieTrailer({super.key, required this.trailerUrl});

  @override
  State<MovieTrailer> createState() => _MovieTrailerState();
}

class _MovieTrailerState extends State<MovieTrailer> {
  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();
    // Extract the video ID from the YouTube URL
    final videoId = YoutubePlayer.convertUrlToId(widget.trailerUrl);

    // Initialize the YouTube player controller with the video ID
    _youtubeController = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.black.withOpacity(0.7), // Semi-transparent background
      body: Stack(
        children: [
          Center(
            // Center the YoutubePlayer
            child: YoutubePlayer(
              controller: _youtubeController,
              showVideoProgressIndicator: true,
              progressColors: const ProgressBarColors(
                playedColor: Colors.red,
                handleColor: Colors.redAccent,
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              padding: const EdgeInsets.all(10),
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}

void showMovieTrailer(BuildContext context, String trailerUrl) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true, // Allows dismissal by tapping outside
    barrierLabel: 'Movie Trailer',
    barrierColor: Colors.black
        .withOpacity(0.7), // Semi-transparent background outside the dialog
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return MovieTrailer(trailerUrl: trailerUrl); // Pass trailer URL here
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      // Create a slide transition from bottom to top
      final tween = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero);
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      );
      return SlideTransition(
        position: tween.animate(curvedAnimation),
        child: child,
      );
    },
  );
}
