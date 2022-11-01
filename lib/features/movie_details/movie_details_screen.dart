import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_lister_app/features/movie_details/bloc/movie_details_bloc.dart';
import 'package:movie_lister_app/features/movie_details/movie_details_repository.dart';

import 'package:movie_lister_app/features/top_movie/models/genre.dart';
import 'package:movie_lister_app/features/top_movie/models/movie.dart';
import 'package:movie_lister_app/features/top_movie/view/widget/movie_card.dart';
import 'package:movie_lister_app/features/top_movie/view/widget/star_rating_bar.dart';
import 'package:movie_lister_app/util/color_constants.dart';
import 'package:movie_lister_app/util/constants.dart';
import 'package:movie_lister_app/util/generics.dart';
import 'package:movie_lister_app/util/widgets/status_snackbars/error_snackbar.dart';

class MovieDetailsScreen extends StatefulWidget {
  static const id = 'MovieDetailsScreen';

  final int movieId;
  final String? moviePoster;
  final bool topMovie;
  final String movieName;
  final String releseYear;
  final String movieGenre;
  final String? movieDescription;
  final int? movieRating;

  final List<Movie> movieList;
  final List<Genre> genreList;

  // ignore: prefer_const_constructors_in_immutables
  MovieDetailsScreen(
      {Key? key,
      required this.movieId,
      this.moviePoster = Constants.defaultMoviePosterUrl,
      this.topMovie = false,
      required this.movieName,
      required this.movieGenre,
      required this.releseYear,
      this.movieRating,
      this.movieDescription,
      required this.movieList,
      required this.genreList})
      : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    // ignore: no_leading_underscores_for_local_identifiers
    const double _movieCardHeight = 200;

    String movieLength = 'Not available';

    Generics generics = Generics();

    return SafeArea(
      child: BlocProvider<MovieDetailsBloc>(
          create: (_) => MovieDetailsBloc(MovieDetailsRepository())
            ..add(RequestMovieDetails(currentMovieId: widget.movieId)),
          child: BlocConsumer<MovieDetailsBloc, MovieDetailsState>(
            listener: (context, state) {
              if (state is MovieDetailsSuccess) {
                movieLength =
                    generics.runtimeGeneratorMethod(state.movieLength);
              } else if (state is MovieDetailsFaliure) {
                ErrorSnackbar().showErrorSnackBar('Something Went Wrong!');
              }
            },
            builder: (context, state) {
              return Scaffold(
                body: (state is MovieDetailsLoading)
                    ? SizedBox(
                        height: screenSize.height,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Stack(
                        children: <Widget>[
                          Container(
                            height: screenSize.height,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(widget.moviePoster!),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 20.0, left: 20),
                                child: SizedBox(
                                  height: screenSize.height / 10,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: SvgPicture.asset(
                                        'assets/icons/back_icon.svg'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: ColorConstants
                                          .movieDetailBackgroundGradientList,
                                      stops: [0.0, 0.08, 0.13])),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    height: screenSize.height / 3,
                                  ),
                                  (widget.topMovie)
                                      ? Text(
                                          'Top movie of the week',
                                          textAlign: TextAlign.left,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                        )
                                      : const SizedBox(),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      (widget.topMovie)
                                          ? SizedBox(
                                              child: SvgPicture.asset(
                                                'assets/icons/top_movie_icon.svg',
                                                height: 50,
                                              ),
                                            )
                                          : const SizedBox(
                                              width: 0,
                                            ),
                                      (widget.topMovie)
                                          ? const SizedBox(
                                              width: 20,
                                            )
                                          : const SizedBox(
                                              width: 20,
                                            ),
                                      Expanded(
                                        child: Text(
                                          widget.movieName,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: (widget.topMovie) ? 70 : 20),
                                      child: Text(
                                        '${widget.releseYear} • ${widget.movieGenre} • $movieLength',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                      )),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: (widget.topMovie) ? 70 : 20),
                                    child: Text(
                                      widget.movieDescription ??
                                          'Description not Available!',
                                      textAlign: TextAlign.left,
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  (widget.movieRating != null)
                                      ? Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: (widget.topMovie)
                                                      ? 70
                                                      : 20),
                                              child: StarRatingBar(
                                                movieRating:
                                                    widget.movieRating!,
                                                ratingBarBackgroundColor:
                                                    ColorConstants
                                                        .inactiveRatingBarColor,
                                              )))
                                      : const SizedBox(),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  Text(
                                    'Also trending',
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: 220 *
                                        widget.movieList.length.toDouble(),
                                    child: AnimationLimiter(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: widget.movieList.length,
                                        itemBuilder: (context, index) {
                                          return AnimationConfiguration
                                              .staggeredList(
                                            position: index,
                                            duration: const Duration(
                                                milliseconds: 375),
                                            child: SlideAnimation(
                                              verticalOffset: 38.0,
                                              child: FadeInAnimation(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: <Widget>[
                                                    SizedBox(
                                                        height:
                                                            _movieCardHeight,
                                                        child: MovieCard(
                                                            posterImageUrl:
                                                                '${Constants.moviePosterBaseUrl}${widget.movieList[index].poster_url}',
                                                            movieName: widget
                                                                .movieList[
                                                                    index]
                                                                .movie_name,
                                                            movieGenre: generics
                                                                .genreNameFinder(
                                                                    widget
                                                                        .genreList,
                                                                    widget
                                                                        .movieList[
                                                                            index]
                                                                        .genre_id_list),
                                                            releseYear: generics
                                                                .releseYearFinder(widget
                                                                    .movieList[
                                                                        index]
                                                                    .release_date),
                                                            movieRating: generics
                                                                .movieRater(widget
                                                                    .movieList[
                                                                        index]
                                                                    .movie_rating),
                                                            topMovie: (widget
                                                                        .movieList[
                                                                            index]
                                                                        .id ==
                                                                    widget
                                                                        .movieList[
                                                                            0]
                                                                        .id)
                                                                ? true
                                                                : false,
                                                            onPressed: () {
                                                              Navigator.pushNamed(
                                                                  context,
                                                                  MovieDetailsScreen
                                                                      .id,
                                                                  arguments: {
                                                                    'movieId': widget
                                                                        .movieList[
                                                                            index]
                                                                        .id,
                                                                    'moviePoster':
                                                                        '${Constants.moviePosterBaseUrl}${widget.movieList[index].poster_url}',
                                                                    'topMovie': (widget
                                                                            .movieList[
                                                                                index]
                                                                            .id ==
                                                                        widget
                                                                            .movieList[0]
                                                                            .id),
                                                                    'movieName': widget
                                                                        .movieList[
                                                                            index]
                                                                        .movie_name,
                                                                    'movieGenre': generics.genreNameFinder(
                                                                        widget
                                                                            .genreList,
                                                                        widget
                                                                            .movieList[index]
                                                                            .genre_id_list),
                                                                    'releseYear': generics.releseYearFinder(widget
                                                                        .movieList[
                                                                            index]
                                                                        .release_date),
                                                                    'movieRating': generics.movieRater(widget
                                                                        .movieList[
                                                                            index]
                                                                        .movie_rating),
                                                                    'movieDescription': widget
                                                                        .movieList[
                                                                            index]
                                                                        .movieDesc,
                                                                    'movieList':
                                                                        widget
                                                                            .movieList,
                                                                    'genreList':
                                                                        widget
                                                                            .genreList
                                                                  });
                                                            })),
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
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 20.0, left: 20.0),
                              child: SizedBox(
                                height: screenSize.height / 10,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Center(
                                      child: InkWell(
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const SizedBox(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              );
            },
          )),
    );
  }
}
