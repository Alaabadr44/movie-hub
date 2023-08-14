import '../../../../core/resources/data_state.dart';
import '../../../../core/resources/pagination_api_model.dart';
import '../entities/movie_entity.dart';
import '../entities/movie_req_entity.dart';

// movie_repository
abstract class MovieRepository {
  // API methods
  Future<DataState<(PaginationApiModel, List<MovieEntity>)>>
      getNowPlayingMovies(MovieRequestEntity reqEntity);

  Future<DataState<(PaginationApiModel, List<MovieEntity>)>>
      getSearchMoviesByName(MovieRequestEntity reqEntity);

  Future<DataState<(PaginationApiModel, List<MovieEntity>)>> getTopRatedMovies(
    MovieRequestEntity reqEntity,
  );

  Future<DataState> getGenres();

  // Database methods
  Future<DataState<(PaginationApiModel, List<MovieEntity>)>> getFavoritesMovie(
    MovieRequestEntity reqEntity,
  );

  Future<void> addFavoriteMovie(MovieEntity article);

  Future<void> unLikeFavoriteMovie(MovieEntity article);
}
