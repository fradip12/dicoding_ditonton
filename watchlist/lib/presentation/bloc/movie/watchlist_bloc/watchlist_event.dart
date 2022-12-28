part of 'watchlist_bloc.dart';

abstract class WatchlistEvent extends Equatable {}

class OnLoadWatchlist extends WatchlistEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}
