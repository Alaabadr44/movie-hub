import 'package:equatable/equatable.dart';

// remote_movies_state
abstract class HomeMoviesScreenState extends Equatable {
  const HomeMoviesScreenState();

  @override
  List<Object> get props => [];
}

class HomeMoviesScreenStateInitial extends HomeMoviesScreenState {}

class ChangingTapBarIndexHomeMoviesScreenState extends HomeMoviesScreenState {}
class ChangedTapBarIndexHomeMoviesScreenState extends HomeMoviesScreenState {}
