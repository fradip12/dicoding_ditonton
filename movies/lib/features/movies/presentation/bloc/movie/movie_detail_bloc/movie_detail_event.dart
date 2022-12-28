part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class OnDetailLoad extends MovieDetailEvent {
  final int id;

  const OnDetailLoad(this.id);
  @override
  List<Object> get props => [id];
}

class OnAddtoWatchlist extends MovieDetailEvent {
  final MovieDetail movie;

  const OnAddtoWatchlist(this.movie);
  @override
  List<Object> get props => [movie];
}
class OnRemoveWatchlist extends MovieDetailEvent {
  final MovieDetail movie;

  const OnRemoveWatchlist(this.movie);
  @override
  List<Object> get props => [movie];
}