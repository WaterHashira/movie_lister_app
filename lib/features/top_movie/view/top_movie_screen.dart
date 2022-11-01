import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_lister_app/features/movie_details/movie_details_screen.dart';
import 'package:movie_lister_app/features/top_movie/bloc/top_movie_bloc.dart';
import 'package:movie_lister_app/features/top_movie/models/genre.dart';
import 'package:movie_lister_app/features/top_movie/models/movie.dart';
import 'package:movie_lister_app/features/top_movie/top_movie_repository.dart';
import 'package:movie_lister_app/features/top_movie/view/widget/movie_card.dart';
import 'package:movie_lister_app/util/color_constants.dart';
import 'package:movie_lister_app/util/constants.dart';
import 'package:movie_lister_app/util/generics.dart';
import 'package:movie_lister_app/util/widgets/custom_bottom_navigation_bar.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:movie_lister_app/util/widgets/status_snackbars/error_snackbar.dart';

class TopMovieScreen extends StatefulWidget {
  static const id = 'TopMovieScreen';

  const TopMovieScreen({Key? key}) : super(key: key);

  @override
  State<TopMovieScreen> createState() => _TopMovieScreenState();
}

class _TopMovieScreenState extends State<TopMovieScreen> {
  Generics generics = Generics();

  List<Genre> genreList = [];
  List<Movie> movieList = [];

  final TextEditingController _searchController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  final double _movieCardHeight = 190;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider<TopMovieBloc>(
        create: (_) =>
            TopMovieBloc(TopMovieRepository())..add(const RequestTopMovies()),
        child: BlocConsumer<TopMovieBloc, TopMovieState>(
            listener: (context, state) {
          if (state is TopMovieSuccess) {
            genreList = state.genreList;
            movieList = state.movieList;
          } else if (state is TopMovieFaliure) {
            ErrorSnackbar().showErrorSnackBar(state.errorMessage);
          }
        }, builder: (context, state) {
          Size screenSize = MediaQuery.of(context).size;

          return Scaffold(
            resizeToAvoidBottomInset: true,
            bottomNavigationBar: const CustomBottomNavigationBar(),
            body: Container(
              padding: const EdgeInsets.all(24.0),
              child: (state is TopMovieLoading)
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Row(
                              //crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Top Movies',
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                                IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return _searchModalSheet(
                                                screenSize, context);
                                          });
                                    },
                                    icon: SvgPicture.asset(
                                        'assets/icons/search_icon.svg')),
                              ]),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Expanded(
                          flex: 7,
                          child: AnimationLimiter(
                            child: RefreshIndicator(
                              child: ListView.builder(
                                controller: _scrollController,
                                itemCount: movieList.length,
                                itemBuilder: (context, index) {
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 375),
                                    child: SlideAnimation(
                                      verticalOffset: 50.0,
                                      child: FadeInAnimation(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            SizedBox(
                                              height: _movieCardHeight,
                                              child: MovieCard(
                                                  posterImageUrl:
                                                      '${Constants.moviePosterBaseUrl}${movieList[index].poster_url}',
                                                  movieName: movieList[index]
                                                      .movie_name,
                                                  movieGenre:
                                                      generics.genreNameFinder(
                                                          genreList,
                                                          movieList[index]
                                                              .genre_id_list),
                                                  releseYear:
                                                      generics.releseYearFinder(
                                                          movieList[index]
                                                              .release_date),
                                                  movieRating:
                                                      generics.movieRater(
                                                          movieList[index]
                                                              .movie_rating),
                                                  topMovie:
                                                      (movieList[index].id ==
                                                          movieList[0].id),
                                                  onPressed: () {
                                                    Navigator.pushNamed(context,
                                                        MovieDetailsScreen.id,
                                                        arguments: {
                                                          'movieId':
                                                              movieList[index]
                                                                  .id,
                                                          'moviePoster':
                                                              '${Constants.moviePosterBaseUrl}${movieList[index].poster_url}',
                                                          'topMovie':
                                                              (movieList[index]
                                                                      .id ==
                                                                  movieList[0]
                                                                      .id),
                                                          'movieName':
                                                              movieList[index]
                                                                  .movie_name,
                                                          'movieGenre': generics
                                                              .genreNameFinder(
                                                                  genreList,
                                                                  movieList[
                                                                          index]
                                                                      .genre_id_list),
                                                          'releseYear': generics
                                                              .releseYearFinder(
                                                                  movieList[
                                                                          index]
                                                                      .release_date),
                                                          'movieRating': generics
                                                              .movieRater(movieList[
                                                                      index]
                                                                  .movie_rating),
                                                          'movieDescription':
                                                              movieList[index]
                                                                  .movieDesc,
                                                          'movieList':
                                                              movieList,
                                                          'genreList': genreList
                                                        });
                                                  }),
                                            ),
                                            const SizedBox(
                                              height: 20.0,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              onRefresh: () => Navigator.of(context)
                                  .pushNamed(TopMovieScreen.id),
                            ),
                          ),
                        )
                      ],
                    ),
            ),
          );
        }),
      ),
    );
  }

  //searchTextField ModalSheet method
  Widget _searchModalSheet(Size screenSize, BuildContext context) {
    return Container(
      height: screenSize.height / 3,
      padding: const EdgeInsets.all(30),
      color: ColorConstants.appGeneralBackgroundColor,
      child: Center(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                onPressed: () {
                  int searchMovieIndex = generics.movieNameIndexFinder(
                      _searchController.text, movieList);
                  Navigator.of(context).pop();
                  if (searchMovieIndex >= 0) {
                    _scrollToIndex(searchMovieIndex);
                  } else {
                    ErrorSnackbar().showErrorSnackBar('Oops! Movie not Found');
                  }
                },
              ),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: Colors.blue)),
              filled: true,
              fillColor: Colors.white,
              hintText: 'Movie Name',
            ),
          ),
        ),
      ),
    );
  }

  // Method that scroll to an item
  void _scrollToIndex(int index) {
    _scrollController.animateTo((_movieCardHeight * index).toDouble(),
        duration: const Duration(seconds: 2), curve: Curves.easeIn);
  }
}
