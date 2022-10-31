import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svgProvider;

import 'package:movie_lister_app/features/top_movie/models/genre.dart';
import 'package:movie_lister_app/features/top_movie/models/movie.dart';
import 'package:movie_lister_app/features/top_movie/view/widget/movie_card.dart';
import 'package:movie_lister_app/features/top_movie/view/widget/star_rating_bar.dart';
import 'package:movie_lister_app/util/color_constants.dart';
import 'package:movie_lister_app/util/constants.dart';
import 'package:movie_lister_app/util/generics.dart';

class MovieDetailsScreen extends StatefulWidget {
  static const id = 'MovieDetailsScreen';

  final int movieId;
  final String? moviePoster;
  final bool topMovie;
  final String movieName;
  final String releseYear;
  final String movieGenre;
  final String movieLength;
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
      required this.movieLength,
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

    Generics generics = Generics();

    return SafeArea(
      child: Scaffold(
        body: Stack(
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
                  padding: const EdgeInsets.only(top: 20.0, left: 20),
                  child: SizedBox(
                    height: screenSize.height / 10,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SvgPicture.asset('assets/icons/back_icon.svg'),
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
                        colors:
                            ColorConstants.movieDetailBackgroundGradientList,
                        stops: [0.0, 0.08, 0.13])),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: screenSize.height / 3,
                    ),
                    (widget.movieId == widget.movieList[0].id)
                        ? Text(
                            'Top movie of the week',
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.headline4,
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: <Widget>[
                        (widget.movieId == widget.movieList[0].id)
                            ? Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: svgProvider.Svg(
                                        'assets/icons/top_movie_icon.svg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : const SizedBox(
                                width: 0,
                              ),
                        (widget.movieId == widget.movieList[0].id)
                            ? const SizedBox(
                                width: 20,
                              )
                            : const SizedBox(
                                width: 20,
                              ),
                        Expanded(
                          child: Text(
                            widget.movieName,
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          '${widget.releseYear} • ${widget.movieGenre} • ${widget.movieLength}',
                          style: Theme.of(context).textTheme.headline4,
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        widget.movieDescription ?? 'Description not Available!',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    (widget.movieRating != null)
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: StarRatingBar(
                                  movieRating: widget.movieRating!,
                                  ratingBarBackgroundColor:
                                      ColorConstants.inactiveRatingBarColor,
                                )))
                        : const SizedBox(),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Also trending',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 185 * widget.movieList.length.toDouble(),
                      child: AnimationLimiter(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.movieList.length,
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
                                        height: 168,
                                        child: MovieCard(
                                            posterImageUrl:
                                                '${Constants.moviePosterBaseUrl}${widget.movieList[index].poster_url}',
                                            movieName: widget
                                                .movieList[index].movie_name,
                                            movieGenre:
                                                generics.genreNameFinder(
                                                    widget.genreList,
                                                    widget.movieList[index]
                                                        .genre_id_list),
                                            releseYear:
                                                generics.releseYearFinder(widget
                                                    .movieList[index]
                                                    .release_date),
                                            movieRating: generics.movieRater(
                                                widget.movieList[index]
                                                    .movie_rating),
                                            topMovie:
                                                (widget.movieList[index].id ==
                                                        widget.movieList[0].id)
                                                    ? true
                                                    : false,
                                            onPressed: () {
                                              Navigator.pushNamed(context,
                                                  MovieDetailsScreen.id,
                                                  arguments: {
                                                    'movieId': widget
                                                        .movieList[index].id,
                                                    'moviePoster':
                                                        '${Constants.moviePosterBaseUrl}${widget.movieList[index].poster_url}',
                                                    'topMovie': (widget
                                                                .movieId ==
                                                            widget.movieList[0]
                                                                .id)
                                                        ? true
                                                        : false,
                                                    'movieName': widget
                                                        .movieList[index]
                                                        .movie_name,
                                                    'movieGenre': generics
                                                        .genreNameFinder(
                                                            widget.genreList,
                                                            widget
                                                                .movieList[
                                                                    index]
                                                                .genre_id_list),
                                                    'releseYear': generics
                                                        .releseYearFinder(widget
                                                            .movieList[index]
                                                            .release_date),
                                                    'movieLength': '2h 5m',
                                                    'movieRating': generics
                                                        .movieRater(widget
                                                            .movieList[index]
                                                            .movie_rating),
                                                    'movieDescription': widget
                                                        .movieList[index]
                                                        .movieDesc,
                                                    'movieList':
                                                        widget.movieList,
                                                    'genreList':
                                                        widget.genreList
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                child: SizedBox(
                  height: screenSize.height / 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      ),
    );
  }
}
