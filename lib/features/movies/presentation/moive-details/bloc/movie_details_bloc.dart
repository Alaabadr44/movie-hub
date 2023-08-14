import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/typedef/app_typedef.dart';
import '../../../domain/use-cases/add_favorite_movie_use_case.dart';
import '../../../domain/use-cases/get_favorites_movie_use_case.dart';
import '../../../domain/use-cases/un_like_favorite_movie_use_case.dart';
import 'movie_details_event.dart';
import 'movie_details_state.dart';

// local_movie_bloc
class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final GetFavoritesMovieUseCase _getFavoritesMovieUseCase;
  final AddFavoriteMovieUseCase _addFavoriteMovieUseCase;
  final UnLikeFavoriteMovieUseCase _unLikeFavoriteMovieUseCase;

  MovieDetailsBloc(this._getFavoritesMovieUseCase,
      this._addFavoriteMovieUseCase, this._unLikeFavoriteMovieUseCase)
      : super(const MovieDetailsStateLoading()) {
    on<OnInitMovieDetailsBloc>(onCheckLikeMovie);
    // on<GetFavoritesMovies>(onGetFavoritesMovies);
    on<ToggleLikeMovieEvent>(toggleLikeMovie);
  }

  static MovieDetailsBloc get(context) =>
      BlocProvider.of<MovieDetailsBloc>(context);

  static PaginatedFavoritesListBloc getP(context) =>
      BlocProvider.of<PaginatedFavoritesListBloc>(context);

  void toggleLikeMovie(
    ToggleLikeMovieEvent toggle,
    Emitter<MovieDetailsState> emit,
  ) async {
    final bool actionState = toggle.state;

    if (actionState) {
      await _addFavoriteMovieUseCase(params: toggle.movie);
    } else {
      await _unLikeFavoriteMovieUseCase(params: toggle.movie);
    }

    add(OnInitMovieDetailsBloc(toggle.movie!));
  }

  void onCheckLikeMovie(
    OnInitMovieDetailsBloc checkLikeMovieEvent,
    Emitter<MovieDetailsState> emit,
  ) async {
    final movie = checkLikeMovieEvent.movie;
    final movies = (await _getFavoritesMovieUseCase()).data!.$2;

    final state = movies.any((element) => element.id! == movie!.id!);
    emit(MovieDetailsCheckedLikeStateDone(isLike: state));
  }
}
