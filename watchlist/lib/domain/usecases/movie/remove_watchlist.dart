
import 'package:common/common.dart';
import 'package:dartz/dartz.dart';
import 'package:movies/movies.dart';

class RemoveWatchlist {
  final MovieRepository repository;

  RemoveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.removeWatchlist(movie);
  }
}
