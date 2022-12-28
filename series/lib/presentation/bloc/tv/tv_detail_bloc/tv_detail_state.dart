part of 'tv_detail_bloc.dart';

abstract class TvDetailState extends Equatable {
  const TvDetailState();
  
  @override
  List<Object> get props => [];
}


class WatchlistTvDialog extends TvDetailState {
  final String message;
  const WatchlistTvDialog(this.message);
  @override
  List<Object> get props => [message];
}

class TvDetailEmpty extends TvDetailState {}

class TvDetailLoading extends TvDetailState {}

class TvDetailError extends TvDetailState {
  final String message;
  const TvDetailError(this.message);
  @override
  List<Object> get props => [message];
}

class TvDetailLoaded extends TvDetailState {
  final TvDetail result;
  final List<TV> recommendations;
  final bool isAddedToWatchlist;
  const TvDetailLoaded(
    this.result,
    this.recommendations,
    this.isAddedToWatchlist,
  );
  @override
  List<Object> get props => [result, recommendations, isAddedToWatchlist];
}

