import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/typedef/app_typedef.dart';
import '../../../../../../../core/widgets/paginations_widgets.dart';
import '../../../../../domain/entities/movie_entity.dart';
import '../../../../../domain/use-cases/get_now_playing_movies_use_case.dart';
import '../../../../widgets/movie_item_view.dart';

class NowPlayingTab extends StatefulWidget {
  const NowPlayingTab({super.key});

  @override
  State<NowPlayingTab> createState() => _NowPlayingTabState();
}

class _NowPlayingTabState extends State<NowPlayingTab> {
  late PaginatedNowPlayingListBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<PaginatedNowPlayingListBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PaginationListViewInTabBar<GetNowPlayingMoviesUseCase, MovieEntity,
        MovieItemView>(
      paginatedLst: (list) => SmartRefresherApp(
        cubit: bloc,
        list: list,
      ),
      child: (entity) => MovieItemView(data: entity),
    );
  }
}
