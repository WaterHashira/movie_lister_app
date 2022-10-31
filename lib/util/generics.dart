import 'package:movie_lister_app/features/top_movie/models/genre.dart';
import 'package:movie_lister_app/features/top_movie/models/movie.dart';

class Generics {
//method for converting rating fro out of 10 to out of 5
  int movieRater(double movieRating) {
    int finalRating = (movieRating / 2).round();
    return finalRating;
  }

//method for converting a genre id to its genre name
  String genreNameFinder(List<Genre> genreObjList, List<int> genreIdList) {
    List<String> genreNameList = [];

    for (int i = 0; i < genreIdList.length; i++) {
      for (int j = 0; j < genreObjList.length; j++) {
        if (genreIdList[i] == genreObjList[j].id) {
          genreNameList.add(genreObjList[i].name);
          genreNameList.add(' / ');
          break;
        }
      }
    }
    String genreString = '';
    if (genreNameList.isNotEmpty) {
      genreNameList.removeAt(genreNameList.length - 1);
      genreString = genreNameList.join();
    }
    return genreString;
  }

//relese year finder
  String releseYearFinder(String releseDate) {
    List<String> relese = releseDate.split('-');
    return relese[0];
  }

//movie searching method
  int movieNameIndexFinder(String? movieName, List<Movie> movieList) {
    if (movieName != null) {
      if (movieList.any((movie) => movie.movie_name == movieName)) {
        return movieList.indexWhere(((movie) => movie.movie_name == movieName));
      }
    }
    return -1;
  }
}
