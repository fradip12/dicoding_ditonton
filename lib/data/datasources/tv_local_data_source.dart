import 'package:ditonton/data/models/tv/tv_table.dart';

import '../../common/exception.dart';
import 'db/database_helper.dart';

abstract class TvLocalDataSource {
  Future<void> cacheNowPlayingTv(List<TvTable> movies);
  Future<void> cachePopularTv(List<TvTable> movies);
  Future<void> cacheTopRatedTv(List<TvTable> movies);
  Future<List<TvTable>> getCachedNowPlayingTv();
  Future<List<TvTable>> getCachedPopularTv();
  Future<List<TvTable>> getCachedTopRatedTv();
  Future<String> insertTvWatchlist(TvTable movie);
  Future<String> removeTvWatchlist(TvTable movie);
  Future<List<TvTable>> getWatchlistTv();
  Future<TvTable?> getTvById(int id);
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<void> cacheNowPlayingTv(List<TvTable> series) async {
    await databaseHelper.clearTvCache('nowplaying');
    await databaseHelper.insertTvCacheTransaction(series, 'nowplaying');
  }

  @override
  Future<void> cachePopularTv(List<TvTable> series) async {
    await databaseHelper.clearTvCache('popular');
    await databaseHelper.insertTvCacheTransaction(series, 'popular');
  }

  @override
  Future<void> cacheTopRatedTv(List<TvTable> series) async {
    await databaseHelper.clearTvCache('toprated');
    await databaseHelper.insertTvCacheTransaction(series, 'toprated');
  }

  @override
  Future<List<TvTable>> getCachedNowPlayingTv() async {
    final result = await databaseHelper.getCacheTv('nowplaying');
    print(result);
    if (result.length > 0) {
      return result.map((data) => TvTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }

  @override
  Future<List<TvTable>> getCachedPopularTv() async {
    final result = await databaseHelper.getCacheTv('popular');
    print(result);
    if (result.length > 0) {
      return result.map((data) => TvTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }

  @override
  Future<List<TvTable>> getCachedTopRatedTv() async {
    final result = await databaseHelper.getCacheTv('toprated');
    print(result);
    if (result.length > 0) {
      return result.map((data) => TvTable.fromMap(data)).toList();
    } else {
      throw CacheException("Can't get the data :(");
    }
  }

  @override
  Future<String> insertTvWatchlist(TvTable movie) async {
    try {
      await databaseHelper.insertTvWatchlist(movie);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeTvWatchlist(TvTable movie) async {
    try {
      await databaseHelper.removeTvWatchlist(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<TvTable>> getWatchlistTv() async {
    final result = await databaseHelper.getWatchlistTv();
    return result.map((data) => TvTable.fromMap(data)).toList();
  }

  @override
  Future<TvTable?> getTvById(int id) async {
    final result = await databaseHelper.getTvById(id);
    if (result != null) {
      return TvTable.fromMap(result);
    } else {
      return null;
    }
  }
}
