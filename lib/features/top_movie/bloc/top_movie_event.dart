part of 'top_movie_bloc.dart';

abstract class TopMovieEvent {
  const TopMovieEvent();
}

class RequestTopMovies extends TopMovieEvent {
  const RequestTopMovies();
}
