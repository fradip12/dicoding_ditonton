
import 'package:common/common.dart';
import 'package:dartz/dartz.dart';
import 'package:movies/movies.dart';


class GetWatchlistMovies {
  final MovieRepository _repository;

  GetWatchlistMovies(this._repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getWatchlistMovies();
  }
}
