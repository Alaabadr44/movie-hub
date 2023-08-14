import 'package:equatable/equatable.dart';

abstract class HomeMoviesScreenEvent  extends Equatable {
  const HomeMoviesScreenEvent();
    @override
  List<Object> get props => [];
}

class HomeMoviesScreenEventInitial extends HomeMoviesScreenEvent {}

class ToggleHomeMoviesScreenEvent extends HomeMoviesScreenEvent {
  final int tapBarIndex;

 const ToggleHomeMoviesScreenEvent(this.tapBarIndex);
    @override
  List<Object> get props => [tapBarIndex];
}
