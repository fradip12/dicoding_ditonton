import 'package:core/core.dart';
import 'package:core/presentation/bloc/movie/watchlist_bloc/watchlist_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    context.read<WatchlistBloc>().add(OnLoadWatchlist());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistBloc>().add(OnLoadWatchlist());
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
              tabs: const [
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
                    child: BlocBuilder<WatchlistBloc, WatchlistState>(
                      builder: (_, state) {
                        if (state is WatchlistEmpty) {
                          return Container();
                        } else if (state is WatchlistLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is WatchlistLoaded) {
                          final data = state.watchlistMovies;
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BlocBuilder<WatchlistBloc, WatchlistState>(
                      builder: (_, state) {
                        if (state is WatchlistEmpty) {
                          return Container();
                        } else if (state is WatchlistLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is WatchlistLoaded) {
                          final data = state.watchlistSeries;
                          return ListView.builder(
                            itemBuilder: (context, index) {
                              final movie = data[index];
                              return TvCard(movie);
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
