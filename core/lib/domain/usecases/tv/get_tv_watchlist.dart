import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import '../../entities/tv/tv.dart';
import '../../repositories/tv_repository.dart';

class GetTvWatchlistMovies {
  final TvRepository _repository;

  GetTvWatchlistMovies(this._repository);

  Future<Either<Failure, List<TV>>> execute() {
    return _repository.getWatchlistTv();
  }
}
