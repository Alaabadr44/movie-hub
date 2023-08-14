import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'home_movies_event.dart';
import 'home_movies_state.dart';

// remote_movies_bloc
class HomeMoviesScreenBloc
    extends Bloc<HomeMoviesScreenEvent, HomeMoviesScreenState> {
  HomeMoviesScreenBloc() : super(HomeMoviesScreenStateInitial()) {
    on<ToggleHomeMoviesScreenEvent>(toggleTapBar);
  }

  int _tapBarIndex = 0;
  int get tapBarIndex => _tapBarIndex;

  static HomeMoviesScreenBloc get(context) =>
      BlocProvider.of<HomeMoviesScreenBloc>(context);

  void toggleTapBar(
      ToggleHomeMoviesScreenEvent event, Emitter<HomeMoviesScreenState> emit) {
    emit(ChangingTapBarIndexHomeMoviesScreenState());

    _tapBarIndex = event.tapBarIndex;
    emit(ChangedTapBarIndexHomeMoviesScreenState());
  }

  List<RefreshController> _refreshControllers = [
    RefreshController(initialRefresh: false),
    RefreshController(initialRefresh: false),
    RefreshController(initialRefresh: false),
  ];

  List<RefreshController> get refreshControllers => _refreshControllers;


}
