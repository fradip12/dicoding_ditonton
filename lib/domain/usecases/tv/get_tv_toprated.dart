import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

import '../../entities/tv/tv.dart';



class GetTvTopRated {
  final TvRepository repository;

  GetTvTopRated(this.repository);

  Future<Either<Failure, List<TV>>> execute() {
    return repository.getTopRated();
  }
}
