import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/genre.dart';
import '../models/movie.dart';
import '../top_movie_repository.dart';

part 'top_movie_event.dart';
part 'top_movie_state.dart';

class TopMovieBloc extends Bloc<TopMovieEvent, TopMovieState> {
  final TopMovieRepository _repo;

  TopMovieBloc(this._repo) : super(const TopMovieInit()) {
    on<RequestTopMovies>(_onRequestTopMovies);
  }

  void _onRequestTopMovies(
    RequestTopMovies event,
    Emitter<TopMovieState> emit,
  ) async {
    emit(const TopMovieLoading());
    try {
      List<Movie> movieList = await _repo.getMovieList();
      List<Genre> genreList = await _repo.getGenreList();
      emit(TopMovieSuccess(movieList: movieList, genreList: genreList));
    } catch (e) {
      emit(TopMovieFaliure(errorMessage: e.toString()));
      debugPrint(e.toString());
      addError(e);
    }
  }
}
