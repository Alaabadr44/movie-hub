import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../core/typedef/app_typedef.dart';
import '../../../../core/widgets/paginations_widgets.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/movie_entity.dart';
import '../../domain/use-cases/get_favorites_movie_use_case.dart';
import '../moive-details/screen/movie_details_screen.dart';
import '../widgets/movie_item_view.dart';

// favorites_movies_view
class FavoritesMoviesView extends StatelessWidget {
  static const String routeName = '/FavoritesMovies';
  const FavoritesMoviesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
  

    return BlocProvider<PaginatedFavoritesListBloc>(
      create: (_) => PaginatedFavoritesListBloc(sl())..onRefreshData(),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: Builder(
        builder: (context) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _onBackButtonTapped(context),
          child: const Icon(Ionicons.chevron_back, color: Colors.black),
        ),
      ),
      title:
          const Text('Favorites Movies', style: TextStyle(color: Colors.black)),
    );
  }

  Widget _buildBody() {
    return PaginationListView<GetFavoritesMovieUseCase, MovieEntity,
        MovieItemView>(
      child: (entity) => MovieItemView(data: entity),
      listPadding: const EdgeInsets.symmetric(horizontal: 20),
    );
  }

  void _onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }



  void _onArticlePressed(BuildContext context, MovieEntity article) {
    Navigator.pushNamed(context, MovieDetailsView.routeName,
        arguments: article);
  }
}
