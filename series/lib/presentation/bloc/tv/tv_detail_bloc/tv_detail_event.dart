part of 'tv_detail_bloc.dart';

abstract class TvDetailEvent extends Equatable {
  const TvDetailEvent();

  @override
  List<Object> get props => [];
}

class OnTvDetailLoad extends TvDetailEvent {
  final int id;

  const OnTvDetailLoad(this.id);
  @override
  List<Object> get props => [id];
}

class OnAddTvtoWatchlist extends TvDetailEvent {
  final TvDetail movie;

  const OnAddTvtoWatchlist(this.movie);
  @override
  List<Object> get props => [movie];
}

class OnTvRemoveWatchlist extends TvDetailEvent {
  final TvDetail movie;

  const OnTvRemoveWatchlist(this.movie);
  @override
  List<Object> get props => [movie];
}
