import 'dart:io';

import 'package:common/common.dart';
import 'package:dartz/dartz.dart';
import '../datasources/tv_local_data_source.dart';
import '../datasources/tv_remote_data_source.dart';
import '../models/tv/tv_table.dart';
import '../../domain/entities/tv/tv.dart';
import '../../domain/entities/tv/tv_detail.dart';
import '../../domain/repositories/tv_repository.dart';

class TvRepositoryImpl implements TvRepository {
  final TvRemoteDataSource remoteDataSource;
  final TvLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  TvRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<TV>>> getNowPlayingTv() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getNowPlayingTv();
        localDataSource
            .cacheNowPlayingTv(result.map((e) => TvTable.fromDTO(e)).toList());
        return Right(result.map((e) => e.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
      }
    } else {
      try {
        final result = await localDataSource.getCachedNowPlayingTv();
        print(result);
        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<TV>>> getPopularTv() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getPopularTv();
        localDataSource
            .cachePopularTv(result.map((e) => TvTable.fromDTO(e)).toList());

        return Right(result.map((e) => e.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
      }
    } else {
      try {
        final result = await localDataSource.getCachedPopularTv();
        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, List<TV>>> getTopRated() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getTopRated();
        localDataSource
            .cacheTopRatedTv(result.map((e) => TvTable.fromDTO(e)).toList());

        return Right(result.map((e) => e.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
      }
    } else {
      try {
        final result = await localDataSource.getCachedTopRatedTv();
        return Right(result.map((model) => model.toEntity()).toList());
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, TvDetail>> getTvDetail(int id) async {
    try {
      final result = await remoteDataSource.getTvDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TV>>> getTvRecommendations(int id) async {
    try {
      final result = await remoteDataSource.getTvRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TV>>> searchSeries(String query) async {
    try {
      final result = await remoteDataSource.searchSeries(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> saveTvWatchlist(TvDetail movie) async {
    try {
      final result =
          await localDataSource.insertTvWatchlist(TvTable.fromEntity(movie));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Either<Failure, String>> removeTvWatchlist(TvDetail movie) async {
    try {
      final result =
          await localDataSource.removeTvWatchlist(TvTable.fromEntity(movie));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<TV>>> getWatchlistTv() async {
    final result = await localDataSource.getWatchlistTv();
    return Right(result.map((data) => data.toEntity()).toList());
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await localDataSource.getTvById(id);
    return result != null;
  }
}
