import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_toprated.dart';
import 'package:flutter/foundation.dart';

import '../../../common/state_enum.dart';

class TopRatedTvNotifier extends ChangeNotifier {
  final GetTvTopRated getTopRatedSeries;

  TopRatedTvNotifier({required this.getTopRatedSeries});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TV> _movies = [];
  List<TV> get movies => _movies;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedSeries.execute();

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
