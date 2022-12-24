import '../../../domain/entities/tv/tv.dart';
import '../../../domain/usecases/tv/get_tv_popular.dart';
import 'package:flutter/foundation.dart';

import 'package:core/core.dart';

class PopularTVNotifier extends ChangeNotifier {
  final GetTvPopular getPopularMovies;

  PopularTVNotifier(this.getPopularMovies);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TV> _movies = [];
  List<TV> get movies => _movies;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularTv() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getPopularMovies.execute();

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
