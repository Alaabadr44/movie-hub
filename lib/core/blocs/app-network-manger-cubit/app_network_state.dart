part of 'app_network_manger_bloc.dart';

sealed class AppNetworkState extends Equatable {
  const AppNetworkState();

  @override
  List<Object> get props => [];
}

final class ConnectToNetworkInitial extends AppNetworkState {}

final class ConnectToNetwork extends AppNetworkState {
  final ConnectivityResult connectivityWaw;
  const ConnectToNetwork(this.connectivityWaw);

  @override
  List<Object> get props => [connectivityWaw];
}

final class NotConnectToNetworkState extends AppNetworkState {
  final InUnConnectedView action;
  const NotConnectToNetworkState(this.action);

  @override
  List<Object> get props => [action];
}
