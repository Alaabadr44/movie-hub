import '../../../../core/resources/data_state.dart';
import '../../../../core/resources/pagination_api_model.dart';
import '../../../../core/use-case/main_use_cases.dart';
import '../entities/movie_entity.dart';
import '../entities/movie_req_entity.dart';
import '../repository/movie_repository.dart';

// get_favorites_movie_use_case
class GetFavoritesMovieUseCase
    implements MainPaginateListUseCase<MovieEntity, MovieRequestEntity> {
  final MovieRepository _movieRepository;

  GetFavoritesMovieUseCase(this._movieRepository);

  @override
  MovieRequestEntity? req = MovieRequestEntity();

  @override
  Future<DataState<(PaginationApiModel, List<MovieEntity>)>> call(
      {MovieRequestEntity? parm}) {
    if (parm != null) {
      parm.page = req?.page;
    }
    return _movieRepository.getFavoritesMovie(parm ?? MovieRequestEntity());
  }
}
