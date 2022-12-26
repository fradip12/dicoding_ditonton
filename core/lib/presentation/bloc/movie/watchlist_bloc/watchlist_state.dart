part of 'watchlist_bloc.dart';

abstract class WatchlistState extends Equatable {
  const WatchlistState();

  @override
  List<Object> get props => [];
}

class WatchlistEmpty extends WatchlistState {}

class WatchlistLoading extends WatchlistState {}

class WatchlistError extends WatchlistState {
  final String message;
  const WatchlistError(this.message);
  @override
  List<Object> get props => [message];
}

class WatchlistLoaded extends WatchlistState {
  final List<Movie> watchlistMovies;
  final RequestState watchlistMoviesState;
  final List<TV> watchlistSeries;
  final RequestState watchlistSeriesState;

  const WatchlistLoaded({
    required this.watchlistMovies,
    required this.watchlistMoviesState,
    required this.watchlistSeries,
    required this.watchlistSeriesState,
  });
  @override
  List<Object> get props => [
        watchlistMovies,
        watchlistMoviesState,
        watchlistSeries,
        watchlistSeriesState,
      ];
}
