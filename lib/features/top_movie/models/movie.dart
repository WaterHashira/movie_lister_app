import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie {
  @JsonKey(name: 'poster_path')
  final String poster_url;

  @JsonKey(name: 'original_title')
  final String movie_name;

  @JsonKey(name: 'genre_ids')
  final List<int> genre_id_list;

  @JsonKey(name: 'vote_average')
  final double movie_rating;

  @JsonKey(name: 'overview')
  final String movieDesc;

  final int id;

  final String release_date;

  const Movie(this.poster_url, this.movie_name, this.genre_id_list,
      this.movie_rating, this.movieDesc, this.id, this.release_date);

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);
}
