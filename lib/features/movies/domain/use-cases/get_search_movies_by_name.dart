// get_search_movies_by_name
import 'package:movies_hub/core/resources/data_state.dart';
import 'package:movies_hub/core/resources/pagination_api_model.dart';

import '../../../../core/use-case/main_use_cases.dart';
import '../entities/movie_entity.dart';
import '../entities/movie_req_entity.dart';
import '../repository/movie_repository.dart';

class GetSearchMoviesByNameUseCae
    implements NetWorkPaginateListUseCase<MovieEntity, MovieRequestEntity?> {
  final MovieRepository _movieRepository;

  GetSearchMoviesByNameUseCae(this._movieRepository);

  @override
  Future<DataState<(PaginationApiModel, List<MovieEntity>)>> call(
      {MovieRequestEntity? parm}) {
    if (parm != null) {
      parm.page = req?.page;
    }
    return _movieRepository.getSearchMoviesByName(parm ?? MovieRequestEntity());
  }

  @override
  MovieRequestEntity? req = MovieRequestEntity();

  searchBy(String query) => req?.q = query;
}
