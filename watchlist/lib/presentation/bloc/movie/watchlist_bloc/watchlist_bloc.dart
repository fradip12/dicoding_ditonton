import 'package:common/common.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:series/series.dart';
import 'package:watchlist/watchlist.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  WatchlistBloc({
    required this.getWatchlistMovies,
    required this.getTvWatchlist,
  }) : super(WatchlistEmpty()) {
    on<OnLoadWatchlist>(_onDetailLoad);
  }

  final GetWatchlistMovies getWatchlistMovies;
  final GetTvWatchlistMovies getTvWatchlist;
  var _watchlistMovie = <Movie>[];
  var _watchlistMovieState = RequestState.Empty;
  var _watchlistSeries = <TV>[];
  var _watchlistSeriesState = RequestState.Empty;
  Future<void> _onDetailLoad(
    OnLoadWatchlist event,
    Emitter<WatchlistState> emit,
  ) async {
    emit(WatchlistLoading());
    _watchlistMovieState = RequestState.Loading;
    _watchlistSeriesState = RequestState.Loading;
    final _movies = await getWatchlistMovies.execute();
    final _series = await getTvWatchlist.execute();
    _movies.fold(
      (failure) {
        _watchlistMovieState = RequestState.Error;
        return emit(WatchlistError(failure.message));
      },
      (movie) {
        _watchlistMovieState = RequestState.Loaded;
        _watchlistMovie = movie;
        _series.fold(
          (l) {
            _watchlistSeriesState = RequestState.Error;
            return emit(WatchlistError(l.message));
          },
          (series) {
            _watchlistSeriesState = RequestState.Loaded;
            _watchlistSeries = series;
            return emit(
              WatchlistLoaded(
                watchlistMovies: _watchlistMovie,
                watchlistMoviesState: _watchlistMovieState,
                watchlistSeries: _watchlistSeries,
                watchlistSeriesState: _watchlistSeriesState,
              ),
            );
          },
        );
      },
    );
  }
}
