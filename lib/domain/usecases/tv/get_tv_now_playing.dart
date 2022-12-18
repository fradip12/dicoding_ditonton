import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

import '../../../common/failure.dart';

class GetTvNowPlayingMovies {
  final TvRepository repository;

  GetTvNowPlayingMovies(this.repository);

  Future<Either<Failure, List<TV>>> execute() {
    return repository.getNowPlayingTv();
  }
}
