import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../core/constants/constants.dart';
import '../../models/res/base_movie_res_model.dart';
import '../../models/res/genres_res_model.dart';

part 'news_api_service.g.dart';

@RestApi(baseUrl: AppGlobalConstants.moviesAPIBaseURL)
abstract class MoviesApiService {
  factory MoviesApiService(Dio dio) = _MoviesApiService;

  @GET(AppGlobalConstants.endPointTopRatedMovies)
  Future<HttpResponse<BaseMovieResModel>> getTopRatedMovies({
    @Query(AppGlobalConstants.queryPage) int? pageNum,
  });

  @GET(AppGlobalConstants.endPointNowPlayingMovies)
  Future<HttpResponse<BaseMovieResModel>> getNowPlayingMovies({
    @Query(AppGlobalConstants.queryPage) int? pageNum,
  });

  @GET(AppGlobalConstants.endPointSearchMovies)
  Future<HttpResponse<BaseMovieResModel>> getSearchMoviesByName({
    @Query(AppGlobalConstants.querySearch) String? query,
    @Query(AppGlobalConstants.queryPage) int? pageNum,
  });


  @GET("genre/movie/list")
  Future<HttpResponse<GenresResModel>> getGenres();
}
