part of 'movie_details_bloc.dart';

abstract class MovieDetailsEvent {
  const MovieDetailsEvent();
}

//for getting the runtime of movie
class RequestMovieDetails extends MovieDetailsEvent {
  final int currentMovieId;
  const RequestMovieDetails({required this.currentMovieId});
}
