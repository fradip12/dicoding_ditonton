import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

import '../../../common/failure.dart';

class GetTvWatchlistMovies {
  final TvRepository _repository;

  GetTvWatchlistMovies(this._repository);

  Future<Either<Failure, List<TV>>> execute() {
    return _repository.getWatchlistTv();
  }
}
