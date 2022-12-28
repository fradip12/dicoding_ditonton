
import 'package:common/common.dart';
import 'package:dartz/dartz.dart';
import '../../repositories/tv_repository.dart';

import '../../entities/tv/tv.dart';

class GetTvPopular {
  final TvRepository repository;

  GetTvPopular(this.repository);

  Future<Either<Failure, List<TV>>> execute() {
    return repository.getPopularTv();
  }
}
