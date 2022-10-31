import 'package:flutter/cupertino.dart';
import 'package:movie_lister_app/features/top_movie/models/movie.dart';

import 'package:dio/dio.dart';
import 'package:movie_lister_app/util/constants.dart';

import 'models/genre.dart';

class TopMovieRepository {
  Dio dio = Dio();

  Map<String, dynamic> movieParams = {
    'api_key': Constants.apiKey,
    'language': 'en-US',
    'sort_by': 'popularity.desc',
    'include_adult': true,
    'include_video': false,
    'page': 1,
    'with_watch_monitization_types': 'flatrate'
  };

  Map<String, dynamic> genreParams = {
    'api_key': Constants.apiKey,
    'language': 'en-US'
  };

  Future<List<Movie>> getMovieList() async {
    final res = await dio.get('${Constants.apiBaseUrl}discover/movie',
        queryParameters: movieParams);
    if (res.data != null) {
      debugPrint(res.toString());

      List<Movie> topMovieList = (res.data['results'] as List)
          .map((movie) => Movie.fromJson(movie))
          .toList();
      return topMovieList;
    } else {
      throw Exception('Something Went Wrong!');
    }
  }

  Future<List<Genre>> getGenreList() async {
    final res = await dio.get('${Constants.apiBaseUrl}genre/movie/list',
        queryParameters: genreParams);
    if (res.data != null) {
      debugPrint(res.toString());
      return (res.data['genres'] as List)
          .map((genre) => Genre.fromJson(genre))
          .toList();
    } else {
      throw Exception('Something Went Wrong!');
    }
  }
}
