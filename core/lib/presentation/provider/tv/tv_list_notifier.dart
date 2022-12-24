import '../../../domain/entities/tv/tv.dart';

import '../../../domain/usecases/tv/get_tv_toprated.dart';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import '../../../domain/usecases/tv/get_tv_now_playing.dart';
import '../../../domain/usecases/tv/get_tv_popular.dart';

class TvListNotifier extends ChangeNotifier {
  var _nowPlayingMovies = <TV>[];
  List<TV> get nowPlayingMovies => _nowPlayingMovies;

  var _popularMovies = <TV>[];
  List<TV> get popularMovies => _popularMovies;

  var _topRatedMovies = <TV>[];
  List<TV> get topRatedMovies => _topRatedMovies;

  RequestState _nowPlayingState = RequestState.Empty;
  RequestState get nowPlayingState => _nowPlayingState;

  RequestState _popularMoviesState = RequestState.Empty;
  RequestState get popularMoviesState => _popularMoviesState;

  RequestState _topRatedMoviesState = RequestState.Empty;
  RequestState get topRatedMoviesState => _topRatedMoviesState;

  String _message = '';
  String get message => _message;

  TvListNotifier({
    required this.getNowPlayingTv,
    required this.getTvPopular,
    required this.getTvToprated,
  });

  final GetTvNowPlayingMovies getNowPlayingTv;
  final GetTvPopular getTvPopular;
  final GetTvTopRated getTvToprated;

  Future<void> fetchNowPlayingMovies() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingTv.execute();
    result.fold(
      (failure) {
        _nowPlayingState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _nowPlayingState = RequestState.Loaded;
        _nowPlayingMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularMovies() async {
    _popularMoviesState = RequestState.Loading;
    notifyListeners();

    final result = await getTvPopular.execute();
    result.fold(
      (failure) {
        _popularMoviesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _popularMoviesState = RequestState.Loaded;
        _popularMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedMovies() async {
    _topRatedMoviesState = RequestState.Loading;
    notifyListeners();

    final result = await getTvToprated.execute();
    result.fold(
      (failure) {
        _topRatedMoviesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _topRatedMoviesState = RequestState.Loaded;
        _topRatedMovies = moviesData;
        notifyListeners();
      },
    );
  }
}
