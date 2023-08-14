import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../core/widgets/app_image_widget.dart';
import '../../../../../injection_container.dart';
import '../../../../../styles/Dimens.dart';
import '../../../../../styles/colors.dart';
import '../../../../../styles/strings.dart';
import '../../../domain/entities/movie_entity.dart';
import '../bloc/movie_details_bloc.dart';
import '../bloc/movie_details_event.dart';
import '../bloc/movie_details_state.dart';

class MovieDetailsView extends StatelessWidget {
  const MovieDetailsView({
    Key? key,
    required this.movie,
  }) : super(key: key);
  static const String routeName = '/MovieDetailsView';
  final MovieEntity? movie;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<MovieDetailsBloc>()..add(OnInitMovieDetailsBloc(movie!)),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: Dimensions.appBarElevation0,
          backgroundColor: Co.trans,
          leading: Builder(
            builder: (context) => GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _onBackButtonTapped(context),
              child: const Icon(Ionicons.chevron_back, color: Co.black),
            ),
          ),
        ),
        body: Stack(
          children: [
            ..._buildBackground(context, movie!),
            _buildMovieInformation(context, movie!),
          ],
        ),
        floatingActionButton: _buildFloatingActionButton(),
      ),
    );
  }

  void _onBackButtonTapped(BuildContext context) {
    Navigator.pop(context);
  }

  void _onFloatingActionButtonPressed(BuildContext context, bool state) {
    BlocProvider.of<MovieDetailsBloc>(context)
        .add(ToggleLikeMovieEvent(movie!, state));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: state
            ? Colors.black
            : Theme.of(context).primaryColor.withOpacity(0.6),
        content: Text(
            state ? AppString.addSuccessfully : AppString.removedSuccessfully),
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return Builder(
      builder: (context) => BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          bool likeState = false;
          if (state is MovieDetailsCheckedLikeStateDone) {
            likeState = state.isLike;
          }

          return FloatingActionButton(
            backgroundColor: likeState ? Co.black : null,
            onPressed: () =>
                _onFloatingActionButtonPressed(context, !likeState),
            child: likeState
                ? const Icon(Icons.favorite, color: Co.white)
                : const Icon(Icons.favorite_border, color: Co.white),
          );
        },
      ),
    );
  }

  Positioned _buildMovieInformation(BuildContext context, MovieEntity movie) {
    return Positioned(
      bottom: 50,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                movie.title!,
                style: const TextStyle(
                  color: Co.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.star, color: Co.yellow),
                  const SizedBox(width: 4),
                  Text(
                    '${movie.voteAverage} (${movie.voteCount.toString()} votes)',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                movie.description!,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(height: 1.75, color: Co.black),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              if (movie.genres.isNotEmpty)
                Wrap(
                  spacing: 8,
                  children: movie.genres.map((genre) {
                    return Chip(label: Text(genre.name));
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBackground(context, MovieEntity movie) {
    return [
      Container(
        height: double.infinity,
        color: Co.white,
      ),
      AppNetWorkImage(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
        url: movie.movieImage ?? "",
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.5,
        fit: BoxFit.fitHeight,
      ),
      const Positioned.fill(
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Co.trans,
                Co.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.3, 0.5],
            ),
          ),
        ),
      ),
    ];
  }
}
