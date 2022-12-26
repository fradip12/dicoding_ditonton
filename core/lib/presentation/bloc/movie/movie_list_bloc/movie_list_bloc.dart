import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core.dart';

part 'movie_list_state.dart';
part 'movie_list_event.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  MovieListBloc({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
  }) : super(MovieListEmpty()) {
    on<OnLoadAll>(_onLoadAll);
  }
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;
  var nowPlayingState = RequestState.Empty;
  var nowPlayingMovies = <Movie>[];
  var popularState = RequestState.Empty;
  var popularMovies = <Movie>[];
  var topRatedState = RequestState.Empty;
  var topRatedMovies = <Movie>[];
  Future<void> _onLoadAll(
    OnLoadAll event,
    Emitter<MovieListState> emit,
  ) async {
    final nowPlaying = await getNowPlayingMovies.execute();
    final popular = await getPopularMovies.execute();
    final topRated = await getTopRatedMovies.execute();
    nowPlaying.fold((l) {
      nowPlayingState = RequestState.Error;
    }, (r) {
      nowPlayingMovies = r;
      nowPlayingState = RequestState.Loaded;
    });
    popular.fold((l) {
      popularState = RequestState.Error;
    }, (r) {
      popularMovies = r;
      popularState = RequestState.Loaded;
    });
    topRated.fold((l) {
      topRatedState = RequestState.Error;
    }, (r) {
      topRatedMovies = r;
      topRatedState = RequestState.Loaded;
    });
    emit(
      MovieListLoaded(
        nowPlayingMovies,
        popularMovies,
        topRatedMovies,
        nowPlayingState,
        popularState,
        topRatedState,
      ),
    );
  }
}
