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
    emit(MovieListLoading());
    final nowPlaying = await getNowPlayingMovies.execute();
    final popular = await getPopularMovies.execute();
    final topRated = await getTopRatedMovies.execute();
    nowPlaying.fold((l) {
      nowPlayingState = RequestState.Error;
      return emit(const MovieListError('Failed'));
    }, (r) {
      nowPlayingMovies = r;
      nowPlayingState = RequestState.Loaded;
    });
    popular.fold((l) {
      popularState = RequestState.Error;
      return emit(const MovieListError('Failed'));
    }, (r) {
      popularMovies = r;
      popularState = RequestState.Loaded;
    });
    topRated.fold((l) {
      topRatedState = RequestState.Error;
      return emit(const MovieListError('Failed'));
    }, (r) {
      topRatedMovies = r;
      topRatedState = RequestState.Loaded;
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
