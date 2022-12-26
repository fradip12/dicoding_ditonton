// import 'package:flutter/foundation.dart';
// import 'package:core/core.dart';

// class WatchlistMovieNotifier extends ChangeNotifier {
//   var _watchlistMovies = <Movie>[];
//   List<Movie> get watchlistMovies => _watchlistMovies;

//   var _watchlistTV = <TV>[];
//   List<TV> get watchlistTV => _watchlistTV;

//   var _watchlistState = RequestState.Empty;
//   RequestState get watchlistState => _watchlistState;

//   var _watchlistTvState = RequestState.Empty;
//   RequestState get watchlistTvState => _watchlistTvState;

//   String _message = '';
//   String get message => _message;

//   WatchlistMovieNotifier({
//     required this.getWatchlistMovies,
//     required this.getTvWatchlist,
//   });

//   final GetWatchlistMovies getWatchlistMovies;
//   final GetTvWatchlistMovies getTvWatchlist;

//   Future<void> fetchWatchlistMovies() async {
//     _watchlistState = RequestState.Loading;
//     notifyListeners();

//     final result = await getWatchlistMovies.execute();
//     result.fold(
//       (failure) {
//         _watchlistState = RequestState.Error;
//         _message = failure.message;
//         notifyListeners();
//       },
//       (moviesData) {
//         _watchlistState = RequestState.Loaded;
//         _watchlistMovies = moviesData;
//         notifyListeners();
//       },
//     );
//   }

//   Future<void> fetchWatchlistTv() async {
//     _watchlistState = RequestState.Loading;
//     notifyListeners();

//     final result = await getTvWatchlist.execute();
//     result.fold(
//       (failure) {
//         _watchlistTvState = RequestState.Error;
//         _message = failure.message;
//         notifyListeners();
//       },
//       (moviesData) {
//         _watchlistTvState = RequestState.Loaded;
//         _watchlistTV = moviesData;
//         notifyListeners();
//       },
//     );
//   }
// }
