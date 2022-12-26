import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:core/core.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-movie';

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    context.read<MovieListBloc>().add(OnLoadAll());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MovieListBloc, MovieListState>(
          builder: (_, state) {
            if (state is MovieListEmpty) {
              return Container();
            } else if (state is MovieListLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MovieListLoaded) {
              final data = state.popular;
              final _state = state.popularState;
              if (_state == RequestState.Error) {
                return const Text('Failed');
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = data[index];
                  return MovieCard(movie);
                },
                itemCount: data.length,
              );
            } else if (state is WatchlistDialog) {
              return const CircularProgressIndicator();
            } else {
              return Text((state as MovieDetailError).message);
            }
          },
        ),
      ),
    );
  }
}
