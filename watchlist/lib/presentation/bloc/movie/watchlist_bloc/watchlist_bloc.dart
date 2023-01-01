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
  var _watchlistMovieState = RequestState.empty;
  var _watchlistSeries = <TV>[];
  var _watchlistSeriesState = RequestState.empty;
  Future<void> _onDetailLoad(
    OnLoadWatchlist event,
    Emitter<WatchlistState> emit,
  ) async {
    emit(WatchlistLoading());
    _watchlistMovieState = RequestState.loading;
    _watchlistSeriesState = RequestState.loading;
    final _movies = await getWatchlistMovies.execute();
    final _series = await getTvWatchlist.execute();
    _movies.fold(
      (failure) {
        _watchlistMovieState = RequestState.error;
        return emit(WatchlistError(failure.message));
      },
      (movie) {
        _watchlistMovieState = RequestState.loaded;
        _watchlistMovie = movie;
        _series.fold(
          (l) {
            _watchlistSeriesState = RequestState.error;
            return emit(WatchlistError(l.message));
          },
          (series) {
            _watchlistSeriesState = RequestState.loaded;
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
