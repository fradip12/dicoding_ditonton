import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core.dart';

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

  Future<void> _onDetailLoad(
    OnLoadWatchlist event,
    Emitter<WatchlistState> emit,
  ) async {
    emit(WatchlistLoading());
    var _watchlistMovie = <Movie>[];
    var _watchlistMovieState = RequestState.Empty;
    var _watchlistSeries = <TV>[];
    var _watchlistSeriesState = RequestState.Empty;
    _watchlistMovieState = RequestState.Loading;
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
