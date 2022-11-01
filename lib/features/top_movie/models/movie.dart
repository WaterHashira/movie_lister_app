// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie {
  @JsonKey(name: 'poster_path')
  // ignore: non_constant_identifier_names
  final String poster_url;

  @JsonKey(name: 'original_title')
  // ignore: non_constant_identifier_names
  final String movie_name;

  @JsonKey(name: 'genre_ids')
  // ignore: non_constant_identifier_names
  final List<int> genre_id_list;

  @JsonKey(name: 'vote_average')
  // ignore: non_constant_identifier_names
  final double movie_rating;

  @JsonKey(name: 'overview')
  final String movieDesc;

  final int id;

  // ignore: non_constant_identifier_names
  final String release_date;

  const Movie(this.poster_url, this.movie_name, this.genre_id_list,
      this.movie_rating, this.movieDesc, this.id, this.release_date);

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);
}
