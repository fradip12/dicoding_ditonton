part of 'recommendation_bloc.dart';

abstract class RecommendationEvent extends Equatable {
  const RecommendationEvent();

  @override
  List<Object> get props => [];
}

class OnRecommendationLoad extends RecommendationEvent {
  final int id;

  const OnRecommendationLoad(this.id);
  @override
  List<Object> get props => [id];
}
