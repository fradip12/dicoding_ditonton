import 'package:core/core.dart';

import '../provider/watchlist_movie_notifier.dart';
import '../widgets/movie_card_list.dart';
import '../widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<WatchlistMovieNotifier>(context, listen: false)
          ..fetchWatchlistMovies()
          ..fetchWatchlistTv());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Future.microtask(
        () => Provider.of<WatchlistMovieNotifier>(context, listen: false)
          ..fetchWatchlistMovies()
          ..fetchWatchlistTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              unselectedLabelColor: Colors.white,
              labelColor: kMikadoYellow,
              tabs: [
                Tab(
                  icon: Text('Movies'),
                ),
                Tab(
                  icon: Text('TV Series'),
                )
              ],
              controller: DefaultTabController.of(context),
              indicatorSize: TabBarIndicatorSize.tab,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Consumer<WatchlistMovieNotifier>(
                      builder: (context, data, child) {
                        if (data.watchlistState == RequestState.Loading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (data.watchlistState == RequestState.Loaded) {
                          return ListView.builder(
                            itemBuilder: (context, index) {
                              final movie = data.watchlistMovies[index];
                              return MovieCard(movie);
                            },
                            itemCount: data.watchlistMovies.length,
                          );
                        } else {
                          return Center(
                            key: Key('error_message'),
                            child: Text(data.message),
                          );
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Consumer<WatchlistMovieNotifier>(
                      builder: (context, data, child) {
                        if (data.watchlistState == RequestState.Loading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (data.watchlistState == RequestState.Loaded) {
                          return ListView.builder(
                            itemBuilder: (context, index) {
                              final movie = data.watchlistTV[index];
                              return TvCard(movie);
                            },
                            itemCount: data.watchlistTV.length,
                          );
                        } else {
                          return Center(
                            key: Key('error_message'),
                            child: Text(data.message),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
