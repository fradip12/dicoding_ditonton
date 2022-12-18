import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/enum.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  final SearchType type;
  static const ROUTE_NAME = '/search';

  const SearchPage({Key? key, required this.type}) : super(key: key);

  String buildTitle(SearchType type) {
    switch (type) {
      case SearchType.MOVIES:
        return 'Movies';
      case SearchType.TVSERIES:
        return 'Series';
      default:
        return '';
    }
  }

  _onSearch(BuildContext context, String query) {
    if (type == SearchType.MOVIES) {
      Provider.of<MovieSearchNotifier>(context, listen: false)
          .fetchMovieSearch(query);
    } else if (type == SearchType.TVSERIES) {
      Provider.of<MovieSearchNotifier>(context, listen: false)
          .fetchTVSearch(query);
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
              onSubmitted: (query) {
                _onSearch(context, query);
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            if (type == SearchType.MOVIES)
              Consumer<MovieSearchNotifier>(
                builder: (context, data, child) {
                  if (data.state == RequestState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (data.state == RequestState.Loaded) {
                    final result = data.searchResult;
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          final movie = data.searchResult[index];
                          return MovieCard(movie);
                        },
                        itemCount: result.length,
                      ),
                    );
                  } else {
                    return Expanded(
                      child: Container(),
                    );
                  }
                },
              ),
            if (type == SearchType.TVSERIES)
              Consumer<MovieSearchNotifier>(
                builder: (context, data, child) {
                  if (data.state == RequestState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (data.state == RequestState.Loaded) {
                    final result = data.searchTVResult;
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          final movie = data.searchTVResult[index];
                          return TvCard(movie);
                        },
                        itemCount: result.length,
                      ),
                    );
                  } else {
                    return Expanded(
                      child: Container(),
                    );
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}
