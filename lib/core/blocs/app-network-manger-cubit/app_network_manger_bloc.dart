import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../enums/app_enums.dart';

part '../app-network-manger-cubit/app_network_state.dart';
// part '../app-network-manger-cubit/app_network_state_event.dart';

class AppNetworkMangerCubit extends Cubit<AppNetworkState> {
  AppNetworkMangerCubit() : super(ConnectToNetworkInitial());

  static get(context) => BlocProvider.of<AppNetworkMangerCubit>(context);

  @override
  Future<void> close() {
    connectionStreamState?.cancel();

    return super.close();
  }

  InUnConnectedView _unConnectedView = InUnConnectedView.blankPage;

  set unConnectedView(InUnConnectedView view) {
    _unConnectedView = view;
  }

  StreamSubscription<InternetConnectionStatus>? connectionStreamState;
  bool? isConnected;
  listenOnStatusChange() {
    // add(CheckConnectStateEvent());
    connectionStreamState =
        InternetConnectionChecker().onStatusChange.listen((event) {
      checkConnectState();
    });
  }

  pauseListenOnStatusChange() {
    connectionStreamState?.pause();
  }

  resumeListenOnStatusChange() {
    connectionStreamState?.resume();
  }

  checkConnectState() async {
    isConnected = await InternetConnectionChecker().hasConnection;
    if (isConnected == true) {
      emit(ConnectToNetwork(await connectToNetworkBy()));
    } else {
      emit(NotConnectToNetworkState(_unConnectedView));
    }
  }

  Future<ConnectivityResult> connectToNetworkBy() async {
    return await (Connectivity().checkConnectivity());
  }

  changeUnConnectedView(InUnConnectedView action) {
    emit(NotConnectToNetworkState(action));
  }

  
}
