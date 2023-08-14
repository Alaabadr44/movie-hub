import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie_entity.dart';

abstract class MovieDetailsState extends Equatable {
  final List<MovieEntity>? movies;

  const MovieDetailsState({this.movies});

  @override
  List<Object> get props => [movies ?? []];
}

class MovieDetailsStateLoading extends MovieDetailsState {
  const MovieDetailsStateLoading();
}

class MovieDetailsStateDone extends MovieDetailsState {
  const MovieDetailsStateDone(List<MovieEntity> articles)
      : super(movies: articles);
}

class MovieDetailsCheckedLikeStateDone extends MovieDetailsState {
  final bool isLike;
  const MovieDetailsCheckedLikeStateDone({
    required this.isLike,
  });
  @override
  List<Object> get props => [isLike];
}
