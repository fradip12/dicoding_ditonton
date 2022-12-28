
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/watchlist.dart';

import '../../../../domain/entities/movie.dart';
import '../../../../domain/entities/movie_detail.dart';
import '../../../../domain/usecases/get_movie_detail.dart';
import '../../../../domain/usecases/get_movie_recommendations.dart';

part 'movie_detail_state.dart';
part 'movie_detail_event.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(MovieDetailEmpty()) {
    on<OnDetailLoad>(_onDetailLoad);
    on<OnAddtoWatchlist>(
      (event, emit) async {
        final detail = event.movie;
        final response = await saveWatchlist.execute(detail);
        response.fold(
          (l) {
            emit(WatchlistDialog(l.message));
          },
          (r) {
            emit(WatchlistDialog(r));
          },
        );
        add(OnDetailLoad(detail.id));
      },
    );
    on<OnRemoveWatchlist>(
      (event, emit) async {
        final detail = event.movie;
        final response = await removeWatchlist.execute(detail);
        response.fold(
          (l) {
            emit(WatchlistDialog(l.message));
          },
          (r) {
            emit(WatchlistDialog(r));
          },
        );
        add(OnDetailLoad(detail.id));
      },
    );
  }
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  Future<void> _onDetailLoad(
    OnDetailLoad event,
    Emitter<MovieDetailState> emit,
  ) async {
    emit(MovieDetailLoading());
    final id = event.id;
    final result = await getMovieDetail.execute(id);
    final recommend = await getMovieRecommendations.execute(id);
    final watchlistStatus = await getWatchListStatus.execute(id);
    result.fold(
      (failure) {
        return emit(MovieDetailError(failure.message));
      },
      (movie) async {
        recommend.fold(
          (l) {
            return emit(MovieDetailError(l.message));
          },
          (r) {
            return emit(
              MovieDetailLoaded(
                movie,
                r,
                watchlistStatus,
              ),
            );
          },
        );
      },
    );
  }
}
