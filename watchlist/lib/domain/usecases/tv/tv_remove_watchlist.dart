
import 'package:common/common.dart';
import 'package:dartz/dartz.dart';
import 'package:series/series.dart';

class RemoveTvWatchlist {
  final TvRepository repository;

  RemoveTvWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvDetail movie) {
    return repository.removeTvWatchlist(movie);
  }
}
