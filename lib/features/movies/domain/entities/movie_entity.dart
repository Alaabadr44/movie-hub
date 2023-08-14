import 'package:equatable/equatable.dart';

import '../../../movies/data/models/res/genres_res_model.dart';
class MovieEntity extends Equatable {
  String? movieImage, title, description;

  double? voteAverage;
  int? voteCount, id;
  List<Genre> genres;

  MovieEntity({
    required this.movieImage,
    required this.description,
    this.id,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
   required this.genres,
  });

  @override
  List<Object?> get props => [
        movieImage,
        title,
        description,
        voteAverage,
        voteCount,
        id,
        genres,
      ];



  MovieEntity copyWith(
      {String? movieImage,
      String? title,
      String? description,
      double? voteAverage,
      int? voteCount,
      int? id,
      List<Genre>? genres,
      bool? isFavorites}) {
    return MovieEntity(
      description: description ?? this.description,
      title: title ?? this.title,
      movieImage: movieImage ?? this.movieImage,
      voteAverage: voteAverage ?? this.voteAverage,
      id: id ?? this.id,
      genres: genres ?? this.genres,
      voteCount: voteCount ?? this.voteCount,
     
    );
  }

  @override
  String toString() {
    return 'MovieEntity(description: $description, voteAverage: $voteAverage, id: $id, genres: $genres,)';
  }
}
