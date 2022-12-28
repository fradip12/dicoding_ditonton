
import 'package:cached_network_image/cached_network_image.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/movie.dart';
import '../bloc/movie/movie_detail_bloc/movie_detail_bloc.dart';
import '../bloc/movie/movie_list_bloc/movie_list_bloc.dart';
import 'movie_detail_page.dart';
import 'popular_movies_page.dart';
import 'top_rated_movies_page.dart';

class HomeMovie extends StatefulWidget {
  @override
  State<HomeMovie> createState() => _HomeMovieState();
}

class _HomeMovieState extends State<HomeMovie> {
  @override
  void initState() {
    super.initState();
    context.read<MovieListBloc>().add(OnLoadAll());
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Now Playing',
              style: kHeading6,
            ),
            BlocBuilder<MovieListBloc, MovieListState>(
              builder: (_, state) {
                if (state is MovieListEmpty) {
                  return Container();
                } else if (state is MovieListLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MovieListLoaded) {
                  return MovieList(state.nowplaying, state.nowPlayingState);
                } else if (state is WatchlistDialog) {
                  return const CircularProgressIndicator();
                } else {
                  return Text((state as MovieDetailError).message);
                }
              },
            ),
            _buildSubHeading(
              title: 'Popular',
              onTap: () =>
                  Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
            ),
            BlocBuilder<MovieListBloc, MovieListState>(
              builder: (_, state) {
                if (state is MovieListEmpty) {
                  return Container();
                } else if (state is MovieListLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MovieListLoaded) {
                  return MovieList(state.popular, state.popularState);
                } else if (state is WatchlistDialog) {
                  return const CircularProgressIndicator();
                } else {
                  return Text((state as MovieDetailError).message);
                }
              },
            ),
         
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
            ),
             BlocBuilder<MovieListBloc, MovieListState>(
              builder: (_, state) {
                if (state is MovieListEmpty) {
                  return Container();
                } else if (state is MovieListLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MovieListLoaded) {
                  return MovieList(state.topRated, state.topRatedState);
                } else if (state is WatchlistDialog) {
                  return const CircularProgressIndicator();
                } else {
                  return Text((state as MovieDetailError).message);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;
  final RequestState state;
  const MovieList(this.movies, this.state, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (state == RequestState.Error) {
      return const Text('Failed');
    }
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
