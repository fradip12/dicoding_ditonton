
import 'package:common/common.dart';
import 'package:dartz/dartz.dart';
import 'package:series/series.dart';

class SaveTvWatchlist {
  final TvRepository repository;

  SaveTvWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvDetail movie) {
    return repository.saveTvWatchlist(movie);
  }
}
