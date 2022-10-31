part of 'top_movie_bloc.dart';

abstract class TopMovieState {
  const TopMovieState();
}

class TopMovieInit extends TopMovieState {
  const TopMovieInit();
}

class TopMovieLoading extends TopMovieState {
  const TopMovieLoading();
}

class TopMovieSuccess extends TopMovieState {
  final List<Movie> movieList;
  final List<Genre> genreList;
  const TopMovieSuccess({required this.movieList, required this.genreList});
}

class TopMovieFaliure extends TopMovieState {
  final String errorMessage;
  const TopMovieFaliure({required this.errorMessage});
}
