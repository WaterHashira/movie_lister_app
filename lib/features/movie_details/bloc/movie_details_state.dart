part of 'movie_details_bloc.dart';

abstract class MovieDetailsState {
  const MovieDetailsState();
}

class MovieDetailsInit extends MovieDetailsState {
  const MovieDetailsInit();
}

class MovieDetailsLoading extends MovieDetailsState {
  const MovieDetailsLoading();
}

class MovieDetailsSuccess extends MovieDetailsState {
  final int movieLength;
  const MovieDetailsSuccess({required this.movieLength});
}

class MovieDetailsFaliure extends MovieDetailsState {
  final String errorMessage;
  const MovieDetailsFaliure({required this.errorMessage});
}
