import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movie_lister_app/features/movie_details/movie_details_screen.dart';
import 'package:movie_lister_app/features/splash/splash_screen.dart';
import 'package:movie_lister_app/features/top_movie/view/top_movie_screen.dart';
import 'package:movie_lister_app/util/widgets/dismiss_keyboard_on_screen_tap.dart';

import 'package:page_transition/page_transition.dart';
//type: PageTransitionType.scale

class RouteGenerator {
  static const initialRoute = SplashScreen.id;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as dynamic;
    log("Pushed ${settings.name}(${args ?? ''})");
    switch (settings.name) {
      case SplashScreen.id:
        return _route(const SplashScreen());
      case TopMovieScreen.id:
        return _route(const TopMovieScreen());
      case MovieDetailsScreen.id:
        return _route(MovieDetailsScreen(
          moviePoster: args?['moviePoster'],
          topMovie: args['topMovie'],
          movieName: args['movieName'],
          movieGenre: args['movieGenre'],
          releseYear: args['releseYear'],
          movieRating: args?['movieRating'],
          movieDescription: args['movieDescription'],
          movieList: args['movieList'],
          genreList: args['genreList'],
          movieId: args['movieId'],
        ));
      default:
        return _errorRoute(settings.name);
    }
  }

  static MaterialPageRoute _route(Widget widget) => MaterialPageRoute(
        builder: (_) => DismissKeyboardOnScreenTap(child: widget),
      );

  static Route<dynamic> _errorRoute(String? name) {
    return _route(
      Scaffold(
        body: Center(
          child: Text('ROUTE\n\n$name\n\nNOT FOUND'),
        ),
      ),
    );
  }
}
