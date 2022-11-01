import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_lister_app/features/top_movie/view/widget/star_rating_bar.dart';

import 'package:movie_lister_app/util/color_constants.dart';
import 'package:movie_lister_app/util/constants.dart';

class MovieCard extends StatelessWidget {
  final String? posterImageUrl;
  final String movieName;
  final String movieGenre;
  final String releseYear;
  final int? movieRating;
  final bool topMovie;
  final void Function() onPressed;
  const MovieCard(
      {Key? key,
      this.posterImageUrl,
      required this.movieName,
      required this.movieGenre,
      required this.releseYear,
      this.movieRating,
      this.topMovie = false,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: (topMovie)
                      ? ColorConstants.activeRatingBarColor
                      : ColorConstants.inactiveRatingBarColor,
                  image: DecorationImage(
                    image: NetworkImage(
                      posterImageUrl ?? Constants.defaultMoviePosterUrl,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: (topMovie)
                    ? ColorConstants.activeCardColor
                    : ColorConstants.inactiveCardColor,
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    (topMovie)
                        ? Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                SvgPicture.asset(
                                    'assets/icons/top_movie_icon.svg'),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Top movie this week',
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(
                            height: 0,
                          ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: Text(
                        movieName,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    Text(
                      movieGenre,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Text(
                      releseYear,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    (movieRating != null)
                        ? Expanded(
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: StarRatingBar(
                                  movieRating: movieRating!,
                                  ratingBarBackgroundColor: (topMovie)
                                      ? ColorConstants.activeRatingBarColor
                                      : ColorConstants.inactiveRatingBarColor,
                                )),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
