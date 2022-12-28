part of 'movie_list_bloc.dart';

abstract class MovieListState extends Equatable {
  const MovieListState();

  @override
  List<Object> get props => [];
}

class MovieListEmpty extends MovieListState {}

class MovieListLoading extends MovieListState {}

class MovieListError extends MovieListState {
  final String message;
  const MovieListError(this.message);
  @override
  List<Object> get props => [message];
}

class MovieListLoaded extends MovieListState {
  final List<Movie> nowplaying;
  final RequestState nowPlayingState;
  final List<Movie> popular;
  final RequestState popularState;
  final List<Movie> topRated;
  final RequestState topRatedState;
  const MovieListLoaded(
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
