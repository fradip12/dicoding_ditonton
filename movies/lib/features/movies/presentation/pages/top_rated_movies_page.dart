import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/movie/movie_detail_bloc/movie_detail_bloc.dart';
import '../bloc/movie/movie_list_bloc/movie_list_bloc.dart';
import '../widgets/movie_card_list.dart';

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
              final data = state.topRated;
              final _state = state.topRatedState;
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
