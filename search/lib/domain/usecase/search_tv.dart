
import 'package:common/common.dart';
import 'package:dartz/dartz.dart';
import 'package:series/series.dart';


class SearchSeries {
  final TvRepository repository;

  SearchSeries(this.repository);

  Future<Either<Failure, List<TV>>> execute(String query) {
    return repository.searchSeries(query);
  }
}
