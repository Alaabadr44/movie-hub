import '../../../../core/use-case/main_use_cases.dart';
import '../entities/movie_entity.dart';
import '../repository/movie_repository.dart';

// add_favorite_movie_use_case
class AddFavoriteMovieUseCase implements MainUseCase<void, MovieEntity> {
  final MovieRepository _movieRepository;

  AddFavoriteMovieUseCase(this._movieRepository);

  @override
  Future<void> call({MovieEntity? params}) {
    return _movieRepository.addFavoriteMovie(params!);
  }
}
