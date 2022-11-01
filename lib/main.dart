import 'package:flutter/material.dart';
import 'package:movie_lister_app/features/top_movie/view/top_movie_screen.dart';
import 'package:movie_lister_app/features/top_movie/view/widget/movie_card.dart';
import 'package:movie_lister_app/util/globals.dart';
import 'package:movie_lister_app/util/route_genertor.dart';
import 'package:movie_lister_app/util/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      onGenerateRoute: RouteGenerator.generateRoute,
      navigatorKey: Globals.navigatorKey,
      scaffoldMessengerKey: Globals.scaffoldMessengerKey,
      initialRoute: RouteGenerator.initialRoute,
      /*home: Scaffold(
        body: Container(
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 250,
              child: MovieCard(
                posterImageUrl:
                    'https://m.media-amazon.com/images/M/MV5BMTE0YWFmOTMtYTU2ZS00ZTIxLWE3OTEtYTNiYzBkZjViZThiXkEyXkFqcGdeQXVyODMzMzQ4OTI@._V1_.jpg',
                movieName: 'Captin Marvel',
                movieGenre: 'Fantasy / Action',
                releseYear: '2019',
                topMovie: true,
                movieRating: 3,
                onPressed: () {},
              ),
            ),
          ),
        ),
      ),*/
      /*MovieDetailsScreen(
        moviePoster:
            'https://m.media-amazon.com/images/M/MV5BMTE0YWFmOTMtYTU2ZS00ZTIxLWE3OTEtYTNiYzBkZjViZThiXkEyXkFqcGdeQXVyODMzMzQ4OTI@._V1_.jpg',
        topMovie: true,
        movieName: 'Captin Marvel',
        movieGenre: 'Fantasy / Action',
        releseYear: '2019',
        movieLength: '2h 5m',
        movieRating: 3,
        movieDescription:
            'Captain Marvel is an extraterrestrial Kree warrior who finds herself caught in the middle of an intergalactic battle between her people and the Skrulls. Living on Earth in 1995, she keeps having recurring memories of another life as U.S. Air Force pilot Carol Danvers. With help from Nick Fury, Captain Marvel tries to uncover the secrets of her past while harnessing her special superpowers to end the war with the evil Skrulls.',
      ),*/
    );
  }
}
