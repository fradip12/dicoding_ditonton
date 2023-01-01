import 'package:common/common.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/movie.dart';
import '../../../../domain/usecases/get_now_playing_movies.dart';
import '../../../../domain/usecases/get_popular_movies.dart';
import '../../../../domain/usecases/get_top_rated_movies.dart';

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
  var nowPlayingState = RequestState.empty;
  var nowPlayingMovies = <Movie>[];
  var popularState = RequestState.empty;
  var popularMovies = <Movie>[];
  var topRatedState = RequestState.empty;
  var topRatedMovies = <Movie>[];
  Future<void> _onLoadAll(
    OnLoadAll event,
    Emitter<MovieListState> emit,
  ) async {
    emit(MovieListLoading());
    final nowPlaying = await getNowPlayingMovies.execute();
    final popular = await getPopularMovies.execute();
    final topRated = await getTopRatedMovies.execute();
    nowPlaying.fold((l) {
      nowPlayingState = RequestState.error;
      return emit(MovieListError(l.message));
    }, (r) {
      nowPlayingMovies = r;
      nowPlayingState = RequestState.loaded;
    });
    popular.fold((l) {
      popularState = RequestState.error;
      return emit(MovieListError(l.message));
    }, (r) {
      popularMovies = r;
      popularState = RequestState.loaded;
    });
    topRated.fold((l) {
      topRatedState = RequestState.error;
      return emit(MovieListError(l.message));
    }, (r) {
      topRatedMovies = r;
      topRatedState = RequestState.loaded;
      return emit(
        MovieListLoaded(
          nowPlayingMovies,
          popularMovies,
          topRatedMovies,
          nowPlayingState,
          popularState,
          topRatedState,
        ),
      );
    });
  }
}
