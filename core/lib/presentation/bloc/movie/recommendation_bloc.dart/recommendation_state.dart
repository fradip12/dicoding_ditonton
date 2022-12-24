part of 'recommendation_bloc.dart';

abstract class RecommendationState extends Equatable {
  const RecommendationState();

  @override
  List<Object> get props => [];
}

class RecommendationsEmpty extends RecommendationState {}

class RecommendationsLoading extends RecommendationState {}

class RecommendationsError extends RecommendationState {
  final String message;
  const RecommendationsError(this.message);
  @override
  List<Object> get props => [message];
}
class RecommendationsLoaded extends RecommendationState {
  final List<Movie> result;
  const RecommendationsLoaded(
    this.result,
  );
  @override
  List<Object> get props => [result];
}
