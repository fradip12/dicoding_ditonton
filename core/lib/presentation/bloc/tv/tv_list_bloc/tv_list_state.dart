part of 'tv_list_bloc.dart';

abstract class TvListState extends Equatable {
  const TvListState();

  @override
  List<Object> get props => [];
}

class TvListInitial extends TvListState {}

class TvListLoading extends TvListState {}

class TvListError extends TvListState {
  final String message;
  const TvListError(this.message);
  @override
  List<Object> get props => [message];
}

class TvListLoaded extends TvListState {
  final List<TV> nowplaying;
  final RequestState nowPlayingState;
  final List<TV> popular;
  final RequestState popularState;
  final List<TV> topRated;
  final RequestState topRatedState;
  const TvListLoaded(
    this.nowplaying,
    this.popular,
    this.topRated,
    this.nowPlayingState,
    this.popularState,
    this.topRatedState,
  );
  @override
  List<Object> get props => [
        nowplaying,
        popular,
        topRated,
        nowPlayingState,
        popularState,
        topRatedState,
      ];
}
