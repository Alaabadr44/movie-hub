import '../../../../core/resources/data_state.dart';
import '../../../../core/resources/pagination_api_model.dart';
import '../../../../core/use-case/main_use_cases.dart';
import '../entities/movie_entity.dart';
import '../entities/movie_req_entity.dart';
import '../repository/movie_repository.dart';

// get_now_playing_movies_use_case

class GetNowPlayingMoviesUseCase
    implements NetWorkPaginateListUseCase<MovieEntity, MovieRequestEntity?> {
  final MovieRepository _movieRepository;

  GetNowPlayingMoviesUseCase(this._movieRepository);

  @override
  Future<DataState<(PaginationApiModel, List<MovieEntity>)>> call(
      {MovieRequestEntity? parm}) {
    if (parm != null) {
      parm.page = req?.page;
    }
    return _movieRepository.getNowPlayingMovies(parm ?? MovieRequestEntity());
  }

  @override
  MovieRequestEntity? req = MovieRequestEntity();
}
