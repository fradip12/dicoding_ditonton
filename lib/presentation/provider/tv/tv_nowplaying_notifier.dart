import 'package:ditonton/domain/usecases/tv/get_tv_now_playing.dart';
import 'package:flutter/foundation.dart';

import '../../../common/state_enum.dart';
import '../../../domain/entities/tv/tv.dart';

class NowPlayingTvNotifier extends ChangeNotifier {
  final GetTvNowPlayingMovies getTvNowPlayingMovies;

  NowPlayingTvNotifier(this.getTvNowPlayingMovies);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TV> _movies = [];
  List<TV> get movies => _movies;

  String _message = '';
  String get message => _message;

  Future<void> fetchNowPlaying() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTvNowPlayingMovies.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (moviesData) {
        _movies = moviesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
