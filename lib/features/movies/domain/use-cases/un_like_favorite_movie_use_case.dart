import '../../../../core/use-case/main_use_cases.dart';
import '../entities/movie_entity.dart';
import '../repository/movie_repository.dart';

// un_like_favorite_movie
class UnLikeFavoriteMovieUseCase implements MainUseCase<void, MovieEntity> {
  final MovieRepository _movieRepository;

  UnLikeFavoriteMovieUseCase(this._movieRepository);

  @override
  Future<void> call({MovieEntity? params}) {
    return _movieRepository.unLikeFavoriteMovie(params!);
  }
}
