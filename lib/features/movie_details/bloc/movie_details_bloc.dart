import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_lister_app/features/movie_details/movie_details_repository.dart';

part 'movie_details_event.dart';
part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final MovieDetailsRepository _repo;

  MovieDetailsBloc(this._repo) : super(const MovieDetailsInit()) {
    on<RequestMovieDetails>(_onRequestMovieDetails);
  }

  void _onRequestMovieDetails(
    RequestMovieDetails event,
    Emitter<MovieDetailsState> emit,
  ) async {
    emit(const MovieDetailsLoading());
    try {
      int movieLength = await _repo.getMovieDetails(event.currentMovieId);

      emit(MovieDetailsSuccess(movieLength: movieLength));
    } catch (e) {
      emit(MovieDetailsFaliure(errorMessage: e.toString()));
      debugPrint(e.toString());
      addError(e);
    }
  }
}
