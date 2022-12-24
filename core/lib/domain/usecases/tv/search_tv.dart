import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../entities/tv/tv.dart';
import '../../repositories/tv_repository.dart';

class SearchSeries {
  final TvRepository repository;

  SearchSeries(this.repository);

  Future<Either<Failure, List<TV>>> execute(String query) {
    return repository.searchSeries(query);
  }
}
