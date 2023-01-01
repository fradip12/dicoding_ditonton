import 'dart:developer';

import 'package:common/common.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:series/series.dart';

class SearchPage extends StatelessWidget {
  final SearchType type;

  const SearchPage({Key? key, required this.type}) : super(key: key);

  String buildTitle(SearchType type) {
    switch (type) {
      case SearchType.movies:
        return 'Movies';
      case SearchType.tvSeries:
        return 'Series';
      default:
        return '';
    }
  }

  _onSearch(BuildContext context, String query) {
    if (type == SearchType.movies) {
      context.read<SearchBloc>().add(OnQueryChanged(query, SearchType.movies));
    } else if (type == SearchType.tvSeries) {
      context
          .read<SearchBloc>()
          .add(OnQueryChanged(query, SearchType.tvSeries));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search ${buildTitle(type)}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                log(query);
                _onSearch(context, query);
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            if (type == SearchType.movies)
              BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
                if (state is SearchLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchHasData) {
                  final result = state.result;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final movie = result[index];
                        return MovieCard(movie);
                      },
                      itemCount: result.length,
                    ),
                  );
                } else if (state is SearchError) {
                  return Expanded(
                    child: Center(
                      child: Text(state.message),
                    ),
                  );
                } else {
                  return Expanded(
                    child: Container(),
                  );
                }
              }),
            if (type == SearchType.tvSeries)
              BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
                if (state is SearchLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchTvHasData) {
                  final result = state.result;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final movie = result[index];
                        return TvCard(movie);
                      },
                      itemCount: result.length,
                    ),
                  );
                } else if (state is SearchError) {
                  return Expanded(
                    child: Center(
                      child: Text(state.message),
                    ),
                  );
                } else {
                  return Expanded(
                    child: Container(),
                  );
                }
              }),
          
          ],
        ),
      ),
    );
  }
}
