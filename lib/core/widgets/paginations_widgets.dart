import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../blocs/pagination-bloc/pagination_bloc.dart';
import '../use-case/main_use_cases.dart';
import 'initial_search_widget.dart';
import 'loading_widget.dart';
import 'no_data_found_widget.dart';

/// class PaginationListView<UseCase extends MainPaginateApiUseCase, Entity,
/// PaginationListItem extends PaginationViewItem> extends StatelessWidget
class PaginationListView<UseCase extends MainPaginateListUseCase, Entity,
    ItemView extends PaginationViewItem> extends StatelessWidget {
  final ItemView Function(Entity entity) child;
  const PaginationListView({
    super.key,
    required this.child,
    this.listPadding,
  });

  final EdgeInsetsGeometry? listPadding;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaginationBloc<UseCase, Entity>, PaginationBlocState>(
      buildWhen: (previous, current) => previous != current,
      builder: (ctx, state) {
        if (state is PaginationLoading) {
          return Container(
            height: 500,
            width: 500,
            alignment: Alignment.center,
            child: const LoadingWidget(),
          );
        }
        if (state is PaginationError) {
          return const Center(child: Icon(Icons.refresh));
        }
        if (state is PaginationLoaded && state.items.isNotEmpty) {
          return ListView.separated(
            padding: listPadding,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              Entity item = state.items[index];
              return child(item);
            },
            itemCount: state.items.length,
          );
        }

        if (state is PaginationLoaded && state.items.isEmpty ||
            state is PaginationNoDataFoundState) {
          return const Center(child: NoDataFoundWidget());
        }
        if (state is PaginationBlocInitial) {
          return const Center(child: InitialSearchWidget());
        }

        return const SizedBox();
      },
    );
  }
}

/// abstract class PaginationViewItem<Entity> extends StatelessWidget
abstract class PaginationViewItem<Entity> extends StatelessWidget {
  final Entity data;
  const PaginationViewItem({
    super.key,
    required this.data,
  });
}

/// class PaginationListView<UseCase extends MainPaginateApiUseCase, Entity,
/// ItemView extends PaginationViewItem> extends StatelessWidget
class PaginationListViewInTabBar<UseCase extends MainPaginateListUseCase,
    Entity, ItemView extends PaginationViewItem> extends StatelessWidget {
  final ItemView Function(Entity entity) child;

  final Widget Function(Widget list) paginatedLst;
  const PaginationListViewInTabBar({
    super.key,
    required this.child,
    required this.paginatedLst,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaginationBloc<UseCase, Entity>, PaginationBlocState>(
      buildWhen: (previous, current) => previous != current,
      builder: (ctx, state) {
        if (state is PaginationLoading) {
          return Container(
            height: 500,
            width: 500,
            alignment: Alignment.center,
            child: const LoadingWidget(),
          );
        }
        if (state is PaginationError) {
          return const Center(child: Icon(Icons.refresh));
        }
        if (state is PaginationLoaded && state.items.isNotEmpty) {
          return paginatedLst(
            ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                Entity item = state.items[index];
                return child(item);
              },
              itemCount: state.items.length,
            ),
          );
        }

        if (state is PaginationLoaded && state.items.isEmpty ||
            state is PaginationNoDataFoundState) {
          return const Center(child: NoDataFoundWidget());
        }
        if (state is PaginationBlocInitial) {
          return const Center(child: InitialSearchWidget());
        }

        return const SizedBox();
      },
    );
  }
}

/// this widget was cereted for tapBar 
/// which has problem in case using one SmartRefresher for many taps 
///  
/// ``` Never Use ``` When (A extends PaginationBloc).refreshController was ``` on null value``` 
class SmartRefresherApp<A extends PaginationBloc> extends StatelessWidget {
  final A cubit;
  final Widget list;
  const SmartRefresherApp({
    super.key,
    required this.cubit,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, right: 20, left: 20),
      child: SmartRefresher(
        controller: cubit.refreshController!,
        enablePullDown: true,
        enablePullUp: true,
        onLoading: cubit.fetchData,
        onRefresh: cubit.onRefreshData,
        child: list,
      ),
    );
  }
}
