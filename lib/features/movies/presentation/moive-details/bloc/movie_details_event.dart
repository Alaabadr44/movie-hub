import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie_entity.dart';

abstract class MovieDetailsEvent extends Equatable {
  final MovieEntity? movie;

  const MovieDetailsEvent({this.movie});

  @override
  List<Object> get props => [movie!];
}

class ToggleLikeMovieEvent extends MovieDetailsEvent {
  final bool state;
  const ToggleLikeMovieEvent(
    MovieEntity movie,
    this.state,
  ) : super(movie: movie);

  @override
  List<Object> get props => [movie!, state];
}

class OnInitMovieDetailsBloc extends MovieDetailsEvent {
  const OnInitMovieDetailsBloc(MovieEntity article) : super(movie: article);
}
