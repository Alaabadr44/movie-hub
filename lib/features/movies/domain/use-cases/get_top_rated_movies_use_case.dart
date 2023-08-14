import '../../../../core/resources/data_state.dart';
import '../../../../core/resources/pagination_api_model.dart';
import '../../../../core/use-case/main_use_cases.dart';
import '../entities/movie_entity.dart';
import '../entities/movie_req_entity.dart';
import '../repository/movie_repository.dart';

class GetTopRatedMoviesUseCase
    implements NetWorkPaginateListUseCase<MovieEntity, MovieRequestEntity?> {
  final MovieRepository _movieRepository;

  GetTopRatedMoviesUseCase(this._movieRepository);

  @override
  Future<DataState<(PaginationApiModel, List<MovieEntity>)>> call(
      {MovieRequestEntity? parm}) async {
    if (parm != null) {
      parm.page = req?.page;
    }
    return _movieRepository.getTopRatedMovies(parm ?? MovieRequestEntity());
  }

  @override
  MovieRequestEntity? req = MovieRequestEntity();
}
