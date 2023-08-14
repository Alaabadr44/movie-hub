import 'package:flutter/material.dart';

import '../../features/movies/domain/entities/movie_entity.dart';
import '../../features/movies/presentation/favorites_movies/favorites_movies_view.dart';
import '../../features/movies/presentation/home/pages/screen/movies_home_view.dart';
import '../../features/movies/presentation/moive-details/screen/movie_details_screen.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case MoviesHomeView.routeName:
        return _materialRoute(const MoviesHomeView());

      case MovieDetailsView.routeName:
        return _materialRoute(
            MovieDetailsView(movie: settings.arguments as MovieEntity));

      case FavoritesMoviesView.routeName:
        return _materialRoute(const FavoritesMoviesView());

      default:
        return _materialRoute(const MoviesHomeView());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
