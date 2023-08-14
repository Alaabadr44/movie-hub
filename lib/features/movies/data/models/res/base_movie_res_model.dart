import 'package:floor/floor.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/resources/base_response.dart';
import '../../../../../core/resources/main_paginate_model.dart';
import '../../../../../core/resources/pagination_api_model.dart';
import '../../../../movies/data/models/res/genres_res_model.dart';
import '../../../../movies/domain/entities/movie_entity.dart';
import '../../repository/movie_repository_impl.dart';

class BaseMovieResModel extends BaseResponse
    implements MainPaginateModel<MovieResModel, PaginationApiModel> {
  BaseMovieResModel({
    this.items,
    this.paginateInfo,
  }) : super(pagination: paginateInfo);
  Map<int, String>? genres;
  @override
  factory BaseMovieResModel.fromJson(Map<String, dynamic> map) {
    return BaseMovieResModel(
      items: map['results'] != null
          ? List<MovieResModel>.from(
              map['results']?.map((x) => MovieResModel.fromMap(x)),
            )
          : null,
      paginateInfo: PaginationApiModel.fromJson(map),
    );
  }

  @override
  List<MovieResModel>? items;

  @override
  PaginationApiModel? paginateInfo;
}

@Entity(tableName: 'movie', primaryKeys: ['id'])
class MovieResModel extends MovieEntity {
  MovieResModel({
    bool? adult,
    String? backdropPath,
    List<int>? genreIds,
    required List<Genre> genres,
    int? id,
    String? originalLanguage,
    String? originalTitle,
    String? description,
    double? popularity,
    String? movieImage,
    DateTime? releaseDate,
    String? title,
    bool? video,
    double? voteAverage,
    int? voteCount,
  }) : super(
          id: id,
          title: title,
          description: description,
          movieImage: movieImage,
          voteAverage: voteAverage,
          voteCount: voteCount,
          genres: genres,
        );

  static List<Genre> _fillGenres(
    List<int>? genreIds,
  ) {
    if ((genreIds?.length ?? 0) != 0) {
      List<Genre> genress = [];
      for (var i = 0; i < genreIds!.length; i++) {
        int id = genreIds[i];

        genress.add(
          Genre(
            id: id,
            name: MovieRepositoryImpl.genres?[id] ?? "",
          ),
        );
      }
      return genress;
    } else {
      return [];
    }
  }

  factory MovieResModel.fromMap(Map<String, dynamic> map) {
    List<int> _genreIdss = map["genre_ids"] == null
        ? []
        : List<int>.from(map["genre_ids"]!.map((x) => x));

    return MovieResModel(
      adult: map["adult"],
      genres: _fillGenres(_genreIdss),
      backdropPath: map["backdrop_path"] != null
          ? AppGlobalConstants.imgUrl(map["backdrop_path"])
          : null,
      genreIds: _genreIdss,
      id: map["id"],
      originalLanguage: map["original_language"],
      originalTitle: map["original_title"],
      description: map["overview"],
      popularity: map["popularity"]?.toDouble(),
      movieImage: map["poster_path"] != null
          ? AppGlobalConstants.imgUrl(map["poster_path"])
          : null,
      releaseDate: map["release_date"] == null &&
              (map["release_date"] as String).isNotEmpty
          ? null
          : DateTime.tryParse(map["release_date"]),
      title: map["title"],
      video: map["video"],
      voteAverage: map["vote_average"]?.toDouble(),
      voteCount: map["vote_count"],
    );
  }

  factory MovieResModel.fromEntity(MovieEntity entity) {
    return MovieResModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      movieImage: entity.movieImage,
      voteAverage: entity.voteAverage,
      voteCount: entity.voteCount,
      genres: entity.genres,
    );
  }
}
