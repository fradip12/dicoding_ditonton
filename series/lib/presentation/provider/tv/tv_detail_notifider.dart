
// import 'package:common/common.dart';
// import 'package:flutter/foundation.dart';
// import 'package:watchlist/watchlist.dart';

// import '../../../domain/entities/tv/tv.dart';
// import '../../../domain/entities/tv/tv_detail.dart';
// import '../../../domain/usecases/tv/get_tv_detail.dart';
// import '../../../domain/usecases/tv/get_tv_recommendations.dart';

// class TvDetailNotifier extends ChangeNotifier {
//   static const watchlistAddSuccessMessage = 'Added to Watchlist';
//   static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

//   final GetTvDetail getTvDetail;
//   final GetTvRecommendations getTvRecommendations;
//   final SaveTvWatchlist saveTvWatchlist;
//   final RemoveTvWatchlist removeTvWatchlist;
//   final GetTvWatchListStatus getTvWatchListStatus;
//   TvDetailNotifier({
//     required this.getTvDetail,
//     required this.getTvRecommendations,
//     required this.saveTvWatchlist,
//     required this.removeTvWatchlist,
//     required this.getTvWatchListStatus,
//   });

//   late TvDetail _movie;
//   TvDetail get movie => _movie;

//   List<TV> _tvRecommendations = [];
//   List<TV> get tvRecommendations => _tvRecommendations;

//   RequestState _recommendationState = RequestState.Empty;
//   RequestState get recommendationState => _recommendationState;

//   RequestState _movieState = RequestState.Empty;
//   RequestState get movieState => _movieState;

//   String _message = '';
//   String get message => _message;

//   bool _isAddedtoWatchlist = false;
//   bool get isAddedToWatchlist => _isAddedtoWatchlist;

//   String _watchlistMessage = '';
//   String get watchlistMessage => _watchlistMessage;

//   Future<void> addWatchlist(TvDetail movie) async {
//     final result = await saveTvWatchlist.execute(movie);

//     await result.fold(
//       (failure) async {
//         _watchlistMessage = failure.message;
//       },
//       (successMessage) async {
//         _watchlistMessage = successMessage;
//       },
//     );

//     await loadWatchlistStatus(movie.id!);
//   }

//   Future<void> removeFromWatchlist(TvDetail movie) async {
//     final result = await removeTvWatchlist.execute(movie);

//     await result.fold(
//       (failure) async {
//         _watchlistMessage = failure.message;
//       },
//       (successMessage) async {
//         _watchlistMessage = successMessage;
//       },
//     );

//     await loadWatchlistStatus(movie.id!);
//   }

//   Future<void> fetchMovieDetail(int id) async {
//     _movieState = RequestState.Loading;
//     notifyListeners();
//     final detailResult = await getTvDetail.execute(id);
//     final recommendation = await getTvRecommendations.execute(id);
//     print(recommendation);
//     detailResult.fold(
//       (failure) {
//         _movieState = RequestState.Error;
//         _message = failure.message;
//         notifyListeners();
//       },
//       (movie) {
//         _movie = movie;
//         notifyListeners();
//         recommendation.fold((l) {
//           _recommendationState = RequestState.Error;
//           _message = l.message;
//         }, (recommend) {
//           _recommendationState = RequestState.Loaded;
//           _tvRecommendations = recommend;
//         });
//         _movieState = RequestState.Loaded;
//         notifyListeners();
//       },
//     );
//   }

//   Future<void> loadWatchlistStatus(int id) async {
//     final result = await getTvWatchListStatus.execute(id);
//     _isAddedtoWatchlist = result;
//     print(result);
//     notifyListeners();
//   }
// }
