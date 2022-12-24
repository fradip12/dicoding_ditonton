import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'recommendation_state.dart';
part 'recommendation_event.dart';

class RecommendationBloc
    extends Bloc<RecommendationEvent, RecommendationState> {
  final GetMovieRecommendations getMovieRecommendations;

  RecommendationBloc(this.getMovieRecommendations)
      : super(RecommendationsEmpty()) {
    on<OnRecommendationLoad>(
      (event, emit) async {
        final id = event.id;
        final recommendations = await getMovieRecommendations.execute(id);
        print(recommendations);
        recommendations.fold(
          (failure) {
            emit(RecommendationsError(failure.message));
          },
          (movies) {
            emit(RecommendationsLoaded(movies));
          },
        );
      },
    );
  }
}
