import 'package:flutter/cupertino.dart';

import 'package:dio/dio.dart';
import 'package:movie_lister_app/util/constants.dart';

class MovieDetailsRepository {
  Dio dio = Dio();

  Map<String, dynamic> movieDetailsParams = {
    'api_key': Constants.apiKey,
    'language': 'en-US'
  };

  Future<int> getMovieDetails(int movieId) async {
    final res = await dio.get('${Constants.apiBaseUrl}movie/$movieId',
        queryParameters: movieDetailsParams);
    if (res.data != null) {
      debugPrint(res.toString());

      int movieLength = res.data['runtime'] ?? 0;

      return movieLength;
    } else {
      throw Exception('Something Went Wrong!');
    }
  }
}
