import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../features/movies/presentation/favorites_movies/favorites_movies_view.dart';
import '../blocs/app-network-manger-cubit/app_network_manger_bloc.dart';
import '../extensions/app_extensions.dart';

class AppNetworkMangerWidget extends StatelessWidget {
  final Widget child;
  const AppNetworkMangerWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppNetworkMangerCubit, AppNetworkState>(
      builder: (context, state) {
        return Scaffold(
          appBar: state.isNotConnectToNetwork
              ? AppBar(
                  title: const Text("No Connection Found"),
                  actions: [
                    GestureDetector(
                      onTap: () => _onShowFavoritesViewTapped(context),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14),
                        child: Icon(Icons.favorite, color: Colors.black),
                      ),
                    )
                  ],
                )
              : null,
          body: body(state),
        );
      },
    );
  }

  Widget body(AppNetworkState state) {
    if (state.isNotConnectToNetwork) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: LottieBuilder.asset(
              'assets/lottie/no-net.json',
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          const Text(
            " You Are not Connect To The Network",
            style: TextStyle(
              fontSize: 18,
            ),
          )
        ],
      );
    } else {
      return child;
    }
  }

  void _onShowFavoritesViewTapped(BuildContext context) {
    Navigator.pushNamed(context, FavoritesMoviesView.routeName);
  }
}
