   
import 'package:common/common.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/series.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvLocalDataSourceImpl dataSource;
  late MockDatabaseSeriesHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseSeriesHelper();
    dataSource = TvLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('insert watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      when(mockDatabaseHelper.insertTvWatchlist(testTvTable))
          .thenAnswer((_) async => 1);
      final result = await dataSource.insertTvWatchlist(testTvTable);
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      when(mockDatabaseHelper.insertTvWatchlist(testTvTable))
          .thenThrow(Exception());
      final call = dataSource.insertTvWatchlist(testTvTable);
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      when(mockDatabaseHelper.removeTvWatchlist(testTvTable))
          .thenAnswer((_) async => 1);
      final result = await dataSource.removeTvWatchlist(testTvTable);
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      when(mockDatabaseHelper.removeTvWatchlist(testTvTable))
          .thenThrow(Exception());
      final call = dataSource.removeTvWatchlist(testTvTable);
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Tv Detail By Id', () {
    final tId = 1;

    test('should return Movie Detail Table when data is found', () async {
      when(mockDatabaseHelper.getTvById(tId))
          .thenAnswer((_) async => testTvMap);
      final result = await dataSource.getTvById(tId);
      expect(result, testTvTable);
    });

    test('should return null when data is not found', () async {
      when(mockDatabaseHelper.getTvById(tId)).thenAnswer((_) async => null);
      final result = await dataSource.getTvById(tId);
      expect(result, null);
    });
  });

  group('get watchlist tv', () {
    test('should return list of Tv Table from database', () async {
      when(mockDatabaseHelper.getWatchlistTv())
          .thenAnswer((_) async => [testTvMap]);
      final result = await dataSource.getWatchlistTv();
      expect(result, [testTvTable]);
    });
  });
  group('cache now playing movies', () {
    test('should call database helper to save data', () async {
      when(mockDatabaseHelper.clearTvCache('nowplaying'))
          .thenAnswer((_) async => 1);
      await dataSource.cacheNowPlayingTv([testTvCache]);
      verify(mockDatabaseHelper.clearTvCache('nowplaying'));
      verify(mockDatabaseHelper
          .insertTvCacheTransaction([testTvCache], 'nowplaying'));
    });

    test('should return list of tv from db when data exist', () async {
      when(mockDatabaseHelper.getCacheTv('nowplaying'))
          .thenAnswer((_) async => [testTvCacheMap]);
      final result = await dataSource.getCachedNowPlayingTv();
      expect(result, [testTvCache]);
    });

    test('should throw CacheException when cache data is not exist', () async {
      when(mockDatabaseHelper.getCacheTv('nowplaying'))
          .thenAnswer((_) async => []);
      final call = dataSource.getCachedNowPlayingTv();
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });
  group('cache popular movies', () {
    test('should call database helper to save data', () async {
      when(mockDatabaseHelper.clearTvCache('popular'))
          .thenAnswer((_) async => 1);
      await dataSource.cachePopularTv([testTvCache]);
      verify(mockDatabaseHelper.clearTvCache('popular'));
      verify(mockDatabaseHelper
          .insertTvCacheTransaction([testTvCache], 'popular'));
    });

    test('should return list of tv from db when data exist', () async {
      when(mockDatabaseHelper.getCacheTv('popular'))
          .thenAnswer((_) async => [testTvCacheMap]);
      final result = await dataSource.getCachedPopularTv();
      expect(result, [testTvCache]);
    });

    test('should throw CacheException when cache data is not exist', () async {
      when(mockDatabaseHelper.getCacheTv('popular'))
          .thenAnswer((_) async => []);
      final call = dataSource.getCachedPopularTv();
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });
  group('cache top rated movies', () {
    test('should call database helper to save data', () async {
      when(mockDatabaseHelper.clearTvCache('toprated'))
          .thenAnswer((_) async => 1);
      await dataSource.cacheTopRatedTv([testTvCache]);
      verify(mockDatabaseHelper.clearTvCache('toprated'));
      verify(mockDatabaseHelper
          .insertTvCacheTransaction([testTvCache], 'toprated'));
    });

    test('should return list of tv from db when data exist', () async {
      when(mockDatabaseHelper.getCacheTv('toprated'))
          .thenAnswer((_) async => [testTvCacheMap]);
      final result = await dataSource.getCachedTopRatedTv();
      expect(result, [testTvCache]);
    });

    test('should throw CacheException when cache data is not exist', () async {
      when(mockDatabaseHelper.getCacheTv('toprated'))
          .thenAnswer((_) async => []);
      final call = dataSource.getCachedTopRatedTv();
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });
}
