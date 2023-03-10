// import '../domain/usecase/search_movies.dart';
// import 'package:flutter/foundation.dart';
// import 'package:core/core.dart';

// class MovieSearchNotifier extends ChangeNotifier {
//   final SearchMovies searchMovies;
//   final SearchSeries searchSeries;
//   MovieSearchNotifier({
//     required this.searchMovies,
//     required this.searchSeries,
//   });

//   RequestState _state = RequestState.empty;
//   RequestState get state => _state;

//   List<Movie> _searchResult = [];
//   List<Movie> get searchResult => _searchResult;

//   List<TV> _searchTVResult = [];
//   List<TV> get searchTVResult => _searchTVResult;

//   String _message = '';
//   String get message => _message;

//   Future<void> fetchMovieSearch(String query) async {
//     _state = RequestState.Loading;
//     notifyListeners();

//     final result = await searchMovies.execute(query);
//     result.fold(
//       (failure) {
//         _message = failure.message;
//         _state = RequestState.error;
//         notifyListeners();
//       },
//       (data) {
//         _searchResult = data;
//         _state = RequestState.loaded;
//         notifyListeners();
//       },
//     );
//   }

//   Future<void> fetchTVSearch(String query) async {
//     _state = RequestState.Loading;
//     notifyListeners();

//     final result = await searchSeries.execute(query);

//     result.fold(
//       (failure) {
//         _message = failure.message;
//         _state = RequestState.error;
//         notifyListeners();
//       },
//       (data) {
//         print(data);
//         _searchTVResult = data;
//         _state = RequestState.loaded;
//         notifyListeners();
//       },
//     );
//   }
// }
