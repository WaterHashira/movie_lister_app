import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StarRatingBar extends StatelessWidget {
  final int movieRating;
  final Color ratingBarBackgroundColor;
  const StarRatingBar(
      {Key? key,
      required this.movieRating,
      required this.ratingBarBackgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: ratingBarBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RatingBarIndicator(
              rating: movieRating.toDouble(),
              itemCount: 5,
              itemSize: 12.0,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, _) {
                return Row(
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/icons/rating_star_icon.svg',
                      height: 20,
                    ),
                    const SizedBox(
                      width: 3,
                    )
                  ],
                );
              }),
          const SizedBox(
            width: 4.0,
          ),
          Text(
            '$movieRating/5',
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    );
  }
}
