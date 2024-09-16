import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../models/auditorium.dart';
import '../models/comment.dart';

import '../screens/main/main_page.dart';
import '../screens/main/home/stacks/movie_detail_screen.dart';
import '../screens/main/home/stacks/comment_detail_screen.dart';

import '../screens/main/auditorium/stacks/screening_selection_screen.dart';

import '../screens/auth/login_screen.dart';

class Routes {
  static const String root = "/";
  static const String home = "home";
  static const String login = "login";
  static const String movieDetail = "movieDetail";
  static const String commentDetailScreen = "commentDetailScreen";
  
  static const String screeningSelectionScreen = "screeningSelectionScreen";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case root:
        return MaterialPageRoute(
          builder: (context) => const MainPage(),
        );

      case home:
        return MaterialPageRoute(
          builder: (context) => const MainPage(),
        );

      case movieDetail:
        return MaterialPageRoute(
          builder: (context) => MovieDetailScreen(movie: settings.arguments as Movie,),
        );

      case commentDetailScreen:
        return MaterialPageRoute(
          builder: (context) => CommentDetailScreen(
            comment: (settings.arguments as List)[0] as Comment,
            movie: (settings.arguments as List)[1] as Movie,
          ),
        );

      case screeningSelectionScreen:
        return MaterialPageRoute(
          builder: (context) => ScreeningSelectionScreen(auditorium: settings.arguments as Auditorium,),
        );

      case login:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('No page route provided'),
            ),
          ),
        );
    }
  }
}
