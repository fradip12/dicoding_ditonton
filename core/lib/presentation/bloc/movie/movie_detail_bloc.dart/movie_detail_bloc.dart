import 'package:core/core.dart';
import 'package:core/presentation/bloc/movie/recommendation_bloc.dart/recommendation_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'movie_detail_state.dart';
part 'movie_detail_event.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(MovieDetailEmpty()) {
    on<OnDetailLoad>((event, emit) async {
      final id = event.id;
      final result = await getMovieDetail.execute(id);
       emit(MovieDetailLoading());
      result.fold(
        (failure) {
          emit(MovieDetailError(failure.message));
        },
        (movie) {
          // recommendations.fold(
          //   (failure) {
          //     emit(RecommendationsError(failure.message));
          //   },
          //   (movies) {
          //     emit(RecommendationsLoaded(movies));
          //   },
          // );
          emit(MovieDetailLoaded(movie));
        },
      );
    });
  }
}
