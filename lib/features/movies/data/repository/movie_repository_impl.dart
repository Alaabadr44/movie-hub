import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/resources/pagination_api_model.dart';
import '../../domain/entities/movie_entity.dart';
import '../../domain/entities/movie_req_entity.dart';
import '../../domain/repository/movie_repository.dart';
import '../data_sources/local/app_database.dart';
import '../data_sources/remote/news_api_service.dart';
import '../models/res/base_movie_res_model.dart';

// movie_repository_impl
class MovieRepositoryImpl implements MovieRepository {
  final MoviesApiService _movieApiService;
  final AppDatabase _appDatabase;

  /// genres is common for all MoviesRepository so call once in contactor
  static Map<int, String>? _genres;
  static Map<int, String>? get genres => _genres;
  MovieRepositoryImpl(this._movieApiService, this._appDatabase);
  @override
  Future<void> unLikeFavoriteMovie(MovieEntity article) async {
    _appDatabase.moviesDAO.deleteMovie(MovieResModel.fromEntity(article));
  }

  @override
  Future<void> addFavoriteMovie(MovieEntity article) async {
    _appDatabase.moviesDAO.insertMovie(MovieResModel.fromEntity(article));
  }

  @override
  Future<DataState<(PaginationApiModel, List<MovieEntity>)>> getFavoritesMovie(
      _) async {
    try {
      List<MovieEntity> movies =
          await _appDatabase.moviesDAO.getFavoritesMovies();
      var paginationInfo =
          PaginationApiModel(hasNext: false, hasPrevious: false);
      return DataSuccess((paginationInfo, movies));
    } catch (e) {
      return DataFailedErrorMsg("$e");
    }
  }

  @override
  Future<DataState<(PaginationApiModel, List<MovieEntity>)>>
      getNowPlayingMovies(MovieRequestEntity reqEntity) async {
    try {
      final httpResponse = await _movieApiService.getNowPlayingMovies(
          pageNum: reqEntity.reqPage);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(
            (httpResponse.data.paginateInfo!, httpResponse.data.items!));
      } else {
        return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioErrorType.response,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<(PaginationApiModel, List<MovieEntity>)>>
      getSearchMoviesByName(MovieRequestEntity reqEntity) async {
    try {
      final httpResponse = await _movieApiService.getSearchMoviesByName(
        query: reqEntity.q,
        pageNum: reqEntity.reqPage,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(
            (httpResponse.data.paginateInfo!, httpResponse.data.items!));
      } else {
        return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioErrorType.response,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<(PaginationApiModel, List<MovieEntity>)>> getTopRatedMovies(
      MovieRequestEntity reqEntity) async {
    try {
      final httpResponse =
          await _movieApiService.getTopRatedMovies(pageNum: reqEntity.reqPage);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess((
          httpResponse.data.paginateInfo!,
          httpResponse.data.items!,
        ));
      } else {
        return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioErrorType.response,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState> getGenres() async {
    try {
      final httpResponse = await _movieApiService.getGenres();

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        _genres = {};
        // _genres ??= httpResponse.data.genres.map((e) => e.toMapEntry());
        for (var element in httpResponse.data.genres) {
          _genres!.addAll({element.id: element.name});
        }

        return const DataSuccess(null);
      } else {
        return DataFailed(DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioErrorType.response,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }
}
