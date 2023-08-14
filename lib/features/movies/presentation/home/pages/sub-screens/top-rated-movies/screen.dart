import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/typedef/app_typedef.dart';
import '../../../../../../../core/widgets/paginations_widgets.dart';
import '../../../../../domain/entities/movie_entity.dart';
import '../../../../../domain/use-cases/get_top_rated_movies_use_case.dart';
import '../../../../widgets/movie_item_view.dart';

class TopRatedTab extends StatefulWidget {
  const TopRatedTab({super.key});

  @override
  State<TopRatedTab> createState() => _TopRatedTabState();
}

class _TopRatedTabState extends State<TopRatedTab> {
  late PaginatedTopRatedListBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<PaginatedTopRatedListBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PaginationListViewInTabBar<GetTopRatedMoviesUseCase, MovieEntity,
        MovieItemView>(
      paginatedLst: (list) {
        return SmartRefresherApp(cubit: bloc,list: list,);
      },
      child: (entity) => MovieItemView(data: entity),
    );
  }
}
