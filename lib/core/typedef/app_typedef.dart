import '../../features/movies/domain/entities/movie_entity.dart';
import '../../features/movies/domain/use-cases/get_favorites_movie_use_case.dart';
import '../../features/movies/domain/use-cases/get_now_playing_movies_use_case.dart';
import '../../features/movies/domain/use-cases/get_search_movies_by_name.dart';
import '../../features/movies/domain/use-cases/get_top_rated_movies_use_case.dart';
import '../blocs/pagination-bloc/pagination_bloc.dart';
import '../use-case/main_use_cases.dart';

/// PB<T extends MainPaginateApiUseCase, E> = PaginationBloc<T, E>
typedef PB<T extends MainPaginateListUseCase, E> = PaginationBloc<T, E>;
typedef PaginatedNowPlayingListBloc
    = PB<GetNowPlayingMoviesUseCase, MovieEntity>;
typedef PaginatedSearchedListBloc
    = PB<GetSearchMoviesByNameUseCae, MovieEntity>;
typedef PaginatedTopRatedListBloc = PB<GetTopRatedMoviesUseCase, MovieEntity>;
typedef PaginatedFavoritesListBloc = PB<GetFavoritesMovieUseCase, MovieEntity>;
