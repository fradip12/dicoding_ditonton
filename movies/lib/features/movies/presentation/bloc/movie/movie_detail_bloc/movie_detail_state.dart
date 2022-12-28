part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class WatchlistDialog extends MovieDetailState {
  final String message;
  const WatchlistDialog(this.message);
  @override
  List<Object> get props => [message];
}

class MovieDetailEmpty extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailError extends MovieDetailState {
  final String message;
  const MovieDetailError(this.message);
  @override
  List<Object> get props => [message];
}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail result;
  final List<Movie> recommendations;
  final bool isAddedToWatchlist;
  const MovieDetailLoaded(
    this.result,
    this.recommendations,
    this.isAddedToWatchlist,
  );
  @override
  List<Object> get props => [result, recommendations, isAddedToWatchlist];
}
