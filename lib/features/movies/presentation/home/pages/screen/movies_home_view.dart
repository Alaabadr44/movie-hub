import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/typedef/app_typedef.dart';
import '../../../../../../injection_container.dart';
import '../../../../../../styles/Dimens.dart';
import '../../../../../../styles/colors.dart';
import '../../../../../../styles/strings.dart';
import '../../../../domain/use-cases/get_search_movies_by_name.dart';
import '../../../favorites_movies/favorites_movies_view.dart';
import '../../bloc/home_movies_bloc.dart';
import '../../bloc/home_movies_event.dart';
import '../../bloc/home_movies_state.dart';
import '../sub-screens/now-playing/screen.dart';
import '../sub-screens/search-movies/screen.dart';
import '../sub-screens/top-rated-movies/screen.dart';

class MoviesHomeView extends StatelessWidget {
  const MoviesHomeView({Key? key}) : super(key: key);
  static const String routeName = '/MoviesHomeView';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeMoviesScreenBloc(),
      child: BlocBuilder<HomeMoviesScreenBloc, HomeMoviesScreenState>(
        builder: (context, state) {
          var bloc = HomeMoviesScreenBloc.get(context);
          return MultiBlocProvider(
            providers: [
              BlocProvider<PaginatedNowPlayingListBloc>(
                create: (_) => PaginatedNowPlayingListBloc(
                    sl(), bloc.refreshControllers[0])
                  ..onRefreshData(),
              ),
              BlocProvider<PaginatedTopRatedListBloc>(
                create: (_) =>
                    PaginatedTopRatedListBloc(sl(), bloc.refreshControllers[1])
                      ..onRefreshData(),
              ),
              BlocProvider<PaginatedSearchedListBloc>(
                create: (_) => PaginatedSearchedListBloc(
                  sl<GetSearchMoviesByNameUseCae>(),
                  bloc.refreshControllers[2],
                ),
              ),
            ],
            child: DefaultTabController(
              length: 3,
              initialIndex: bloc.tapBarIndex,
              child: Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  actions: [
                    GestureDetector(
                      onTap: () => _onShowFavoritesViewTapped(context),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingW14),
                        child: const Icon(Icons.favorite, color: Co.black),
                      ),
                    )
                  ],
                  title: const Text(AppString.appName),
                  bottom: TabBar(
                    onTap: (value) =>
                        bloc.add(ToggleHomeMoviesScreenEvent(value)),
                    tabs: const [
                      Tab(text: AppString.tapNowPlaying),
                      Tab(text: AppString.tapTopRated),
                      Tab(text: AppString.tapSearch),
                    ],
                  ),
                ),
                body: const TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    NowPlayingTab(),
                    TopRatedTab(),
                    SearchMovieTab(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onShowFavoritesViewTapped(BuildContext context) {
    Navigator.pushNamed(context, FavoritesMoviesView.routeName);
  }
}
