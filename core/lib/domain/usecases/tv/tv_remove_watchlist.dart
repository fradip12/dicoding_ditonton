import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import '../../entities/tv/tv_detail.dart';
import '../../repositories/tv_repository.dart';

class RemoveTvWatchlist {
  final TvRepository repository;

  RemoveTvWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvDetail movie) {
    return repository.removeTvWatchlist(movie);
  }
}
