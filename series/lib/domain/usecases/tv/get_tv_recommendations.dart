
import 'package:common/common.dart';
import 'package:dartz/dartz.dart';
import '../../entities/tv/tv.dart';
import '../../repositories/tv_repository.dart';

class GetTvRecommendations {
  final TvRepository repository;

  GetTvRecommendations(this.repository);

  Future<Either<Failure, List<TV>>> execute(id) {
    return repository.getTvRecommendations(id);
  }
}
