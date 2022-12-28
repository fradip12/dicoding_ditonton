
import 'package:common/common.dart';
import 'package:dartz/dartz.dart';
import 'package:series/series.dart';

class GetTvWatchlistMovies {
  final TvRepository _repository;

  GetTvWatchlistMovies(this._repository);

  Future<Either<Failure, List<TV>>> execute() {
    return _repository.getWatchlistTv();
  }
}
