import 'package:floor/floor.dart';

import '../../../models/res/base_movie_res_model.dart';

@dao
abstract class MovieDao {
  @Insert()
  Future<void> insertMovie(MovieResModel article);

  @delete
  Future<void> deleteMovie(MovieResModel articleModel);

  @Query('SELECT * FROM movie')
  Future<List<MovieResModel>> getFavoritesMovies();
}
