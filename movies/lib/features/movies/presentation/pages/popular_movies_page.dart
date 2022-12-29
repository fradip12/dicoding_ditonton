import 'package:common/common.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import '../bloc/movie/movie_list_bloc/movie_list_bloc.dart';
import '../widgets/movie_card_list.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie';

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    context.read<MovieListBloc>().add(OnLoadAll());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
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
            } else {
              return Text((state as MovieListError).message);
            }
          },
        ),
      ),
    );
  }
}
