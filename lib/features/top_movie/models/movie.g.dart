// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      json['poster_path'] as String,
      json['original_title'] as String,
      (json['genre_ids'] as List<dynamic>).map((e) => e as int).toList(),
      (json['vote_average'] as num).toDouble(),
      json['overview'] as String,
      json['id'] as int,
      json['release_date'] as String,
    );

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'poster_path': instance.poster_url,
      'original_title': instance.movie_name,
      'genre_ids': instance.genre_id_list,
      'vote_average': instance.movie_rating,
      'overview': instance.movieDesc,
      'id': instance.id,
      'release_date': instance.release_date,
    };
