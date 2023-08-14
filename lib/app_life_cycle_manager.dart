import 'package:flutter/material.dart';

import 'core/blocs/app-network-manger-cubit/app_network_manger_bloc.dart';

class AppLifeCycleManager extends StatefulWidget {
  final Widget child;

  const AppLifeCycleManager({
    required this.child,
    super.key,
  });

  @override
  _AppLifeCycleManagerState createState() => _AppLifeCycleManagerState();
}

class _AppLifeCycleManagerState extends State<AppLifeCycleManager>
    with WidgetsBindingObserver {
  late AppNetworkMangerCubit netWortBloc;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    netWortBloc = AppNetworkMangerCubit.get(context);
  }

  onResumedAppState() {
    netWortBloc.resumeListenOnStatusChange();
  }

  onDetachedAppState() {
    netWortBloc.close();
  }

  onPausedAppState() {
    netWortBloc.pauseListenOnStatusChange();
  }

  onInactiveAppState() {
    netWortBloc.pauseListenOnStatusChange();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        debugPrint('app resumed');
        onResumedAppState();
        break;
      case AppLifecycleState.detached:
        debugPrint('app detached');
        onDetachedAppState();
        break;

      case AppLifecycleState.paused:
        debugPrint('app paused');
        onPausedAppState();
        break;

      case AppLifecycleState.inactive:
        debugPrint(" app inactive ");
        onInactiveAppState();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // @override
  // void didChangeAccessibilityFeatures() {
  //   // TODO: implement didChangeAccessibilityFeatures
  // }

  // @override
  // void didChangeLocales(List<Locale>? locales) {
  //   // TODO: implement didChangeLocales
  // }

  // @override
  // void didChangeMetrics() {
  //   // TODO: implement didChangeMetrics
  // }

  // @override
  // void didChangePlatformBrightness() {
  //   // TODO: implement didChangePlatformBrightness
  // }

  // @override
  // void didChangeTextScaleFactor() {
  //   // TODO: implement didChangeTextScaleFactor
  // }

  // @override
  // void didHaveMemoryPressure() {
  //   // TODO: implement didHaveMemoryPressure
  // }

  // @override
  // Future<bool> didPopRoute() {
  //   // TODO: implement didPopRoute
  //   throw UnimplementedError();
  // }

  // @override
  // Future<bool> didPushRoute(String route) {
  //   // TODO: implement didPushRoute
  //   throw UnimplementedError();
  // }

  // @override
  // Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
  //   // TODO: implement didPushRouteInformation
  //   throw UnimplementedError();
  // }

  // @override
  // Future<AppExitResponse> didRequestAppExit() {
  //   // TODO: implement didRequestAppExit
  //   throw UnimplementedError();
  // }
}
