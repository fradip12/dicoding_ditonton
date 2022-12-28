import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:series/domain/entities/tv/tv.dart';
import 'package:series/domain/usecases/tv/get_tv_detail.dart';
import 'package:series/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:watchlist/watchlist.dart';

import '../../../../domain/entities/tv/tv_detail.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';


class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  TvDetailBloc({
    required this.getTvDetail,
    required this.getTvRecommendations,
    required this.getTvWatchListStatus,
    required this.saveTvWatchlist,
    required this.removeTvWatchlist,
  }) : super(TvDetailEmpty()) {
    on<OnTvDetailLoad>(_onDetailLoad);
    on<OnAddTvtoWatchlist>(
      (event, emit) async {
        final detail = event.movie;
        final response = await saveTvWatchlist.execute(detail);
        response.fold(
          (l) {
            emit(WatchlistTvDialog(l.message));
          },
          (r) {
            emit(WatchlistTvDialog(r));
          },
        );
        add(OnTvDetailLoad(detail.id!));
      },
    );
    on<OnTvRemoveWatchlist>(
      (event, emit) async {
        final detail = event.movie;
        final response = await removeTvWatchlist.execute(detail);
        response.fold(
          (l) {
            emit(WatchlistTvDialog(l.message));
          },
          (r) {
            emit(WatchlistTvDialog(r));
          },
        );
        add(OnTvDetailLoad(detail.id!));
      },
    );
  }
  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;
  final GetTvWatchListStatus getTvWatchListStatus;
  final SaveTvWatchlist saveTvWatchlist;
  final RemoveTvWatchlist removeTvWatchlist;

  Future<void> _onDetailLoad(
    OnTvDetailLoad event,
    Emitter<TvDetailState> emit,
  ) async {
    emit(TvDetailLoading());
    final id = event.id;
    final result = await getTvDetail.execute(id);
    final recommend = await getTvRecommendations.execute(id);
    final watchlistStatus = await getTvWatchListStatus.execute(id);
    result.fold(
      (failure) {
        return emit(TvDetailError(failure.message));
      },
      (movie) async {
        recommend.fold(
          (l) {
            return emit(TvDetailError(l.message));
          },
          (r) {
            return emit(
              TvDetailLoaded(
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
