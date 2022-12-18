import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

import '../../../common/failure.dart';
import '../../entities/tv/tv.dart';

class SearchSeries {
  final TvRepository repository;

  SearchSeries(this.repository);

  Future<Either<Failure, List<TV>>> execute(String query) {
    return repository.searchSeries(query);
  }
}
