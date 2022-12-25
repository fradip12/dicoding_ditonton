// import 'package:core/core.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// part 'watchlist_event.dart';
// part 'watchlist_state.dart';

// class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
//   final GetWatchListStatus getWatchListStatus;
//   final SaveWatchlist saveWatchlist;
//   final RemoveWatchlist removeWatchlist;

//   WatchlistBloc(
//       this.getWatchListStatus, this.saveWatchlist, this.removeWatchlist)
//       : super(WatchlistEmpty()) {
//     bool isAdded = false;
//     // String message = '';
//     on<OnSaveWatchlist>((event, emit) async {
//       final movie = event.movie;
//       final result = await saveWatchlist.execute(movie);
//       add(OnGetWatchlistStatus(movie.id));
//       await result.fold(
//         (failure) async {
//           emit(WatchlistLoaded(isAdded, message: failure.message));
//         },
//         (successMessage) async {
//           print(successMessage);
//           emit(WatchlistLoaded(isAdded, message: successMessage));
//         },
//       );
//     });
//     on<OnRemoveWatchlist>((event, emit) async {
//       final movie = event.movie;
//       final result = await removeWatchlist.execute(movie);
//       add(OnGetWatchlistStatus(movie.id));
//       await result.fold(
//         (failure) async {
//           emit(WatchlistLoaded(isAdded, message: failure.message));
//         },
//         (successMessage) async {
//           emit(WatchlistLoaded(isAdded, message: successMessage));
//         },
//       );
//     });
//     on<OnGetWatchlistStatus>((event, emit) async {
//       final id = event.id;
//       final status = await getWatchListStatus.execute(id);
//       isAdded = status;
//       emit(WatchlistLoaded(isAdded, message: ''));
//     });
//   }
// }
