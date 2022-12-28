
import 'package:common/common.dart';
import 'package:dartz/dartz.dart';
import '../../entities/tv/tv.dart';
import '../../repositories/tv_repository.dart';

class GetTvNowPlayingMovies {
  final TvRepository repository;

  GetTvNowPlayingMovies(this.repository);

  Future<Either<Failure, List<TV>>> execute() {
    return repository.getNowPlayingTv();
  }
}
