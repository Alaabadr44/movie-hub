import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'core/blocs/app-network-manger-cubit/app_network_manger_bloc.dart';
import 'features/movies/data/data_sources/local/app_database.dart';
import 'features/movies/data/data_sources/remote/news_api_service.dart';
import 'features/movies/data/repository/movie_repository_impl.dart';
import 'features/movies/domain/repository/movie_repository.dart';
import 'features/movies/domain/use-cases/add_favorite_movie_use_case.dart';
import 'features/movies/domain/use-cases/get_favorites_movie_use_case.dart';
import 'features/movies/domain/use-cases/get_now_playing_movies_use_case.dart';
import 'features/movies/domain/use-cases/get_search_movies_by_name.dart';
import 'features/movies/domain/use-cases/get_top_rated_movies_use_case.dart';
import 'features/movies/domain/use-cases/un_like_favorite_movie_use_case.dart';
import 'features/movies/presentation/home/bloc/home_movies_bloc.dart';
import 'features/movies/presentation/moive-details/bloc/movie_details_bloc.dart';
import 'networking/dio_client.dart';

final sl = GetIt.instance;

final getIt = sl();

Future<void> initializeDependencies() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);

  // Dio
  sl.registerSingleton<Dio>(DioClient.instance);

  // Dependencies
  sl.registerSingleton<MoviesApiService>(MoviesApiService(sl()));

  sl.registerSingleton<MovieRepository>(MovieRepositoryImpl(sl(), sl()));
  await sl<MovieRepository>().getGenres();

  sl.registerFactory<AppNetworkMangerCubit>(() => AppNetworkMangerCubit());

  //UseCases

  sl.registerSingleton<GetFavoritesMovieUseCase>(
      GetFavoritesMovieUseCase(sl()));

  sl.registerSingleton<AddFavoriteMovieUseCase>(AddFavoriteMovieUseCase(sl()));

  sl.registerSingleton<UnLikeFavoriteMovieUseCase>(
      UnLikeFavoriteMovieUseCase(sl()));

  sl.registerSingleton<GetNowPlayingMoviesUseCase>(
      GetNowPlayingMoviesUseCase(sl()));

  sl.registerSingleton<GetTopRatedMoviesUseCase>(
      GetTopRatedMoviesUseCase(sl()));

  sl.registerSingleton<GetSearchMoviesByNameUseCae>(
      GetSearchMoviesByNameUseCae(sl()));

  //Blocs
  sl.registerFactory<HomeMoviesScreenBloc>(() => HomeMoviesScreenBloc());

  sl.registerFactory<MovieDetailsBloc>(
      () => MovieDetailsBloc(sl(), sl(), sl()));
}
