import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../models/auditorium.dart';
import '../models/screening.dart';
import '../models/comment.dart';

import '../../features/main/main_page.dart';
import '../../features/main/home/stacks/movie_detail_screen.dart';
import '../../features/main/home/stacks/comment_detail_screen.dart';
import '../../features/main/home/stacks/screening_selection_by_movie.dart';

import '../../features/main/auditorium/stacks/screening_selection_screen.dart';

import '../../features/main/product/stacks/product_auditorium_selection.dart';

// Booking
import '../../features/booking/seat_selection_screen.dart';
import '../../features/booking/product_selection.dart';
import '../../features/booking/payment_info.dart';

import '../../features/settings/settings_screen.dart';
import '../../features/settings/stacks/edit_profile.dart';

import '../../features/auth/login_screen.dart';

class Routes {
  static const String root = "/";

  static const String home = "home";
  static const String movieDetail = "movieDetail";
  static const String commentDetailScreen = "commentDetailScreen";
  static const String screeningSelectionByMovie = "screeningSelectionByMovie";

  static const String screeningSelectionScreen = "screeningSelectionScreen";

  static const String productAuditoriumSelection = "productAuditoriumSelection";

  // Booking
  static const String seatSelectionScreen = "seatSelectionScreen";
  static const String productSelection = "productSelection";
  static const String paymentInfo = "paymentInfo";

  static const String settingsScreen = "settings";
  static const String editProfile = "editProfile";

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
          builder: (context) => MovieDetailScreen(
            movie: settings.arguments as Movie,
          ),
        );

      case commentDetailScreen:
        return MaterialPageRoute(
          builder: (context) => CommentDetailScreen(
            comment: (settings.arguments as List)[0] as Comment,
            movie: (settings.arguments as List)[1] as Movie,
          ),
        );

      case screeningSelectionByMovie:
        return MaterialPageRoute(
          builder: (context) => ScreeningSelectionByMovie(
            movie: settings.arguments as Movie,
          ),
        );

      case screeningSelectionScreen:
        return MaterialPageRoute(
          builder: (context) => ScreeningSelectionScreen(
            auditorium: settings.arguments as Auditorium,
          ),
        );

      // Product page
      case productAuditoriumSelection:
        return MaterialPageRoute(
          builder: (context) => const ProductAuditoriumSelection(),
        );

      // Booking
      case seatSelectionScreen:
        return MaterialPageRoute(
          builder: (context) => SeatSelectionScreen(
            auditorium: (settings.arguments as List)[0] as Auditorium,
            screening: (settings.arguments as List)[1] as Screening,
          ),
        );

      case productSelection:
        return MaterialPageRoute(
          builder: (context) => const ProductSelection(),
        );

      case paymentInfo:
        return MaterialPageRoute(
          builder: (context) => const PaymentInfo(),
        );

      case settingsScreen:
        return MaterialPageRoute(
          builder: (context) => const SettingsScreen(),
        );

      case editProfile:
        return MaterialPageRoute(
          builder: (context) => const EditProfile(),
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
