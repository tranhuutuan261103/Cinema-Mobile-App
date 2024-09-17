import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../models/auditorium.dart';
import '../models/comment.dart';

import '../../features/main/main_page.dart';
import '../../features/main/home/stacks/movie_detail_screen.dart';
import '../../features/main/home/stacks/comment_detail_screen.dart';

import '../../features/main/auditorium/stacks/screening_selection_screen.dart';

import '../../features/main/product/stacks/product_auditorium_selection.dart';

import '../../features/stacks/settings_screen.dart';

import '../../features/auth/login_screen.dart';

class Routes {
  static const String root = "/";
  static const String home = "home";
  static const String movieDetail = "movieDetail";
  static const String commentDetailScreen = "commentDetailScreen";
  
  static const String screeningSelectionScreen = "screeningSelectionScreen";

  static const String productAuditoriumSelection = "productAuditoriumSelection";

  static const String settingsScreen = "settings";

  static const String login = "login";

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

      // Product page
      case productAuditoriumSelection:
        return MaterialPageRoute(
          builder: (context) => const ProductAuditoriumSelection(),
        );

      case settingsScreen:
        return MaterialPageRoute(
          builder: (context) => const SettingsScreen(),
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
