import 'package:connectivity_plus/connectivity_plus.dart';

import '../blocs/app-network-manger-cubit/app_network_manger_bloc.dart';
import '../enums/app_enums.dart';

extension Size on ImgSize {
  String get imgSize {
    switch (this) {
      case ImgSize.large:
        return "w500";

      case ImgSize.medium:
        return "w300";

      case ImgSize.small:
        return "w200";
      default:
        return "w300";
    }
  }
}

extension NState on AppNetworkState {
  bool get isConnectToNetwork => (this is ConnectToNetwork);

  bool get isNotConnectToNetwork => (this is NotConnectToNetworkState);
}

extension KNet on ConnectivityResult {
  bool get isMobileData => (this == ConnectivityResult.mobile);
  bool get isWifi => (this == ConnectivityResult.wifi);
  bool get isBluetooth => (this == ConnectivityResult.bluetooth);
  bool get isVpn => (this == ConnectivityResult.vpn);
  bool get isEthernet => (this == ConnectivityResult.ethernet);
  bool get isOther => (this == ConnectivityResult.other);
  bool get isUnConnected => (this == ConnectivityResult.none);
}
