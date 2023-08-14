import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/typedef/app_typedef.dart';
import '../../../../../../../core/widgets/paginations_widgets.dart';
import '../../../../../../../injection_container.dart';
import '../../../../../../../styles/Dimens.dart';
import '../../../../../domain/entities/movie_entity.dart';
import '../../../../../domain/use-cases/get_search_movies_by_name.dart';
import '../../../../widgets/movie_item_view.dart';
import 'widget/search_input_widget.dart';

class SearchMovieTab extends StatefulWidget {
  const SearchMovieTab({super.key});

  @override
  State<SearchMovieTab> createState() => _SearchMovieTabState();
}

class _SearchMovieTabState extends State<SearchMovieTab> {
  late PaginatedSearchedListBloc bloc;
  late GetSearchMoviesByNameUseCae getSearchMoviesByNameUseCae;
  late TextEditingController controller;

  late Debouncer debouncer;

  // Run a search whenever the user pauses while typing.

  @override
  void initState() {
    getSearchMoviesByNameUseCae = GetSearchMoviesByNameUseCae(sl());
    bloc = BlocProvider.of<PaginatedSearchedListBloc>(context);
    controller = TextEditingController();
    controller.addListener(() => debouncer.value = controller.text);
    debouncer = Debouncer<String>(
      const Duration(milliseconds: 800),
      initialValue: "",
      onChanged: (value) {
        // bloc.showLoadingScreen;
      },
    );
    debouncer.values.listen((search) => submitSearch(search));

    super.initState();
  }

  @override
  void dispose() {
    // for make sure in end screen remove list
    bloc.beReadyForSearch(getReadyForSearch: () {
      bloc.showEmptyScreen;
      return false;
    });
    controller.dispose();

    super.dispose();
  }

  var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(Dimensions.bRadius30),
    borderSide: const BorderSide(color: Colors.transparent),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        elevation: Dimensions.appBarElevation0,
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: Dimensions.paddingW10),
          child: SearchInput(
            hintText: "search here",
            textController: controller,
            onChanged: (_) => bloc.showLoadingScreen,
            onSubmitted: submitSearch,
          ),
        ),
      ),
      body: PaginationListViewInTabBar<GetSearchMoviesByNameUseCae, MovieEntity,
          MovieItemView>(
        paginatedLst: (list) {
          return SmartRefresherApp(
            cubit: bloc,
            list: list,
          );
        },
        child: (entity) => MovieItemView(data: entity),
      ),
    );
  }

  submitSearch(String value) {
    if (value.isEmpty) {
      bloc.beReadyForSearch(getReadyForSearch: () {
        bloc.showEmptyScreen;
        return false;
      });
    } else {
      bloc.beReadyForSearch(
        getReadyForSearch: () {
          bloc.useCase.searchBy(value);
          return true;
        },
      );
    }
  }
}
