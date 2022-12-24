import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import '../entities/tv/tv.dart';
import '../entities/tv/tv_detail.dart';

abstract class TvRepository {
  Future<Either<Failure, List<TV>>> getNowPlayingTv();
  Future<Either<Failure, List<TV>>> getPopularTv();
  Future<Either<Failure, List<TV>>> getTopRated();
  Future<Either<Failure, TvDetail>> getTvDetail(int id);
  Future<Either<Failure, List<TV>>> getTvRecommendations(int id);
  Future<Either<Failure, List<TV>>> searchSeries(String query);
  Future<Either<Failure, String>> saveTvWatchlist(TvDetail movie);
  Future<Either<Failure, String>> removeTvWatchlist(TvDetail movie);
  Future<Either<Failure, List<TV>>> getWatchlistTv();
  Future<bool> isAddedToWatchlist(int id);
}
