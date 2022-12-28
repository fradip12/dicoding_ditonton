import 'dart:io';
import 'package:common/common.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';
import 'package:series/series.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvRepositoryImpl repo;
  late MockTvRemoteDataSource mockRemoteSource;
  late MockTvLocalDataSource mockLocalSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockRemoteSource = MockTvRemoteDataSource();
    mockLocalSource = MockTvLocalDataSource();
    repo = TvRepositoryImpl(
      remoteDataSource: mockRemoteSource,
      networkInfo: mockNetworkInfo,
      localDataSource: mockLocalSource,
    );
  });
  final tTvmodel = TvModel(
    name: 'name',
    firstAirDate: '01-01-2022',
    originCountry: ['ID'],
    originalLanguage: 'ID',
    originalName: 'name',
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: '1',
    voteCount: 1,
  );

  final tTv = TV(
    name: 'name',
    firstAirDate: '01-01-2022',
    originCountry: ['ID'],
    originalLanguage: 'ID',
    originalName: 'name',
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: '1',
    voteCount: 1,
  );

  final tTvModelList = <TvModel>[tTvmodel];
  final tTvList = <TV>[tTv];

  group("now playing tv series", () {
    group("when device is online", () {
      setUp(() {
        when(mockNetworkInfo.isConnected)
            .thenAnswer((realInvocation) async => true);
      });

      test("should check device is online", () async {
        when(mockRemoteSource.getNowPlayingTv())
            .thenAnswer((realInvocation) async => []);
        await repo.getNowPlayingTv();
        verify(mockNetworkInfo.isConnected);
      });

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        when(mockRemoteSource.getNowPlayingTv())
            .thenAnswer((_) async => tTvModelList);
        final result = await repo.getNowPlayingTv();
        verify(mockRemoteSource.getNowPlayingTv());
        final resultList = result.getOrElse(() => []);
        expect(resultList, tTvList);
      });

      test(
          'should return server failure when call to data source is unsuccessful',
          () async {
        when(mockRemoteSource.getNowPlayingTv()).thenThrow(ServerException());
        final result = await repo.getNowPlayingTv();
        expect(result, Left(ServerFailure('')));
      });
    });

    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return cached data when device is offline', () async {
        when(mockLocalSource.getCachedNowPlayingTv())
            .thenAnswer((_) async => [testTvCache]);
        final result = await repo.getNowPlayingTv();
        verify(mockLocalSource.getCachedNowPlayingTv());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testTvFromCache]);
      });

      test('should return CacheFailure when app has no cache', () async {
        when(mockLocalSource.getCachedNowPlayingTv())
            .thenThrow(CacheException('No Cache'));
        final result = await repo.getNowPlayingTv();
        verify(mockLocalSource.getCachedNowPlayingTv());
        expect(result, Left(CacheFailure('No Cache')));
      });
    });
  });

  group("popular tv series", () {
    group("when device is online", () {
      setUp(() {
        when(mockNetworkInfo.isConnected)
            .thenAnswer((realInvocation) async => true);
      });

      test("should check device is online", () async {
        when(mockRemoteSource.getPopularTv())
            .thenAnswer((realInvocation) async => []);
        await repo.getPopularTv();
        verify(mockNetworkInfo.isConnected);
      });

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        when(mockRemoteSource.getPopularTv())
            .thenAnswer((_) async => tTvModelList);
        final result = await repo.getPopularTv();
        verify(mockRemoteSource.getPopularTv());
        final resultList = result.getOrElse(() => []);
        expect(resultList, tTvList);
      });

      test(
          'should return server failure when call to data source is unsuccessful',
          () async {
        when(mockRemoteSource.getPopularTv()).thenThrow(ServerException());
        final result = await repo.getPopularTv();
        expect(result, Left(ServerFailure('')));
      });
    });

    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return cached data when device is offline', () async {
        when(mockLocalSource.getCachedPopularTv())
            .thenAnswer((_) async => [testTvCache]);
        final result = await repo.getPopularTv();
        verify(mockLocalSource.getCachedPopularTv());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testTvFromCache]);
      });

      test('should return CacheFailure when app has no cache', () async {
        when(mockLocalSource.getCachedPopularTv())
            .thenThrow(CacheException('No Cache'));
        final result = await repo.getPopularTv();
        verify(mockLocalSource.getCachedPopularTv());
        expect(result, Left(CacheFailure('No Cache')));
      });
    });
  });

  group("top Rated tv series", () {
    group("when device is online", () {
      setUp(() {
        when(mockNetworkInfo.isConnected)
            .thenAnswer((realInvocation) async => true);
      });

      test("should check device is online", () async {
        when(mockRemoteSource.getTopRated())
            .thenAnswer((realInvocation) async => []);
        await repo.getTopRated();
        verify(mockNetworkInfo.isConnected);
      });

      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        when(mockRemoteSource.getTopRated())
            .thenAnswer((_) async => tTvModelList);
        final result = await repo.getTopRated();
        verify(mockRemoteSource.getTopRated());
        final resultList = result.getOrElse(() => []);
        expect(resultList, tTvList);
      });

      test(
          'should return server failure when call to data source is unsuccessful',
          () async {
        when(mockRemoteSource.getTopRated()).thenThrow(ServerException());
        final result = await repo.getTopRated();
        expect(result, Left(ServerFailure('')));
      });
    });

    group('when device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test('should return cached data when device is offline', () async {
        when(mockLocalSource.getCachedTopRatedTv())
            .thenAnswer((_) async => [testTvCache]);
        final result = await repo.getTopRated();
        verify(mockLocalSource.getCachedTopRatedTv());
        final resultList = result.getOrElse(() => []);
        expect(resultList, [testTvFromCache]);
      });

      test('should return CacheFailure when app has no cache', () async {
        when(mockLocalSource.getCachedTopRatedTv())
            .thenThrow(CacheException('No Cache'));
        final result = await repo.getTopRated();
        verify(mockLocalSource.getCachedTopRatedTv());
        expect(result, Left(CacheFailure('No Cache')));
      });
    });
  });

  group('Get TV Detail', () {
    final tId = 1;
    final tTvResponse = TvDetailResponse(
        adult: false,
        backdropPath: 'backdropPath',
        genres: [GenreModel(id: 1, name: 'Action')],
        id: 1,
        originalLanguage: 'en',
        overview: 'overview',
        popularity: 1,
        posterPath: 'posterPath',
        status: 'Status',
        tagline: 'Tagline',
        voteAverage: 1,
        voteCount: 1,
        createdBy: [],
        episodeRunTime: [],
        inProduction: true,
        languages: ['id'],
        name: 'name',
        numberOfEpisodes: 2,
        numberOfSeasons: 2,
        originCountry: ['id'],
        originalName: 'name',
        seasons: [],
        spokenLanguages: [],
        type: '');

    test(
        'should return Movie data when the call to remote data source is successful',
        () async {
      when(mockRemoteSource.getTvDetail(tId))
          .thenAnswer((_) async => tTvResponse);
      final result = await repo.getTvDetail(tId);
      verify(mockRemoteSource.getTvDetail(tId));
      expect(result, equals(Right(testTvDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      when(mockRemoteSource.getTvDetail(tId)).thenThrow(ServerException());
      final result = await repo.getTvDetail(tId);
      verify(mockRemoteSource.getTvDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      when(mockRemoteSource.getTvDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      final result = await repo.getTvDetail(tId);
      verify(mockRemoteSource.getTvDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get TV Recommendations', () {
    final tTvList = <TvModel>[];
    final tId = 1;

    test('should return data (movie list) when the call is successful',
        () async {
      when(mockRemoteSource.getTvRecommendations(tId))
          .thenAnswer((_) async => tTvList);
      final result = await repo.getTvRecommendations(tId);
      verify(mockRemoteSource.getTvRecommendations(tId));
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      when(mockRemoteSource.getTvRecommendations(tId))
          .thenThrow(ServerException());
      final result = await repo.getTvRecommendations(tId);
      verify(mockRemoteSource.getTvRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      when(mockRemoteSource.getTvRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      final result = await repo.getTvRecommendations(tId);
      verify(mockRemoteSource.getTvRecommendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Search Series', () {
    final tQuery = 'Bhagya';

    test('should return movie list when call to data source is successful',
        () async {
      when(mockRemoteSource.searchSeries(tQuery))
          .thenAnswer((_) async => tTvModelList);
      final result = await repo.searchSeries(tQuery);
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      when(mockRemoteSource.searchSeries(tQuery)).thenThrow(ServerException());
      final result = await repo.searchSeries(tQuery);
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      when(mockRemoteSource.searchSeries(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      final result = await repo.searchSeries(tQuery);
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      when(mockLocalSource.insertTvWatchlist(testTvTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      final result = await repo.saveTvWatchlist(testTvDetail);
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      when(mockLocalSource.insertTvWatchlist(testTvTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      final result = await repo.saveTvWatchlist(testTvDetail);
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });
  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      when(mockLocalSource.removeTvWatchlist(testTvTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      final result = await repo.removeTvWatchlist(testTvDetail);
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      when(mockLocalSource.removeTvWatchlist(testTvTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      final result = await repo.removeTvWatchlist(testTvDetail);
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });
  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      final tId = 1;
      when(mockLocalSource.getTvById(tId)).thenAnswer((_) async => null);
      final result = await repo.isAddedToWatchlist(tId);
      expect(result, false);
    });
  });
  group('get watchlist tv', () {
    test('should return list of tv', () async {
      when(mockLocalSource.getWatchlistTv())
          .thenAnswer((_) async => [testTvTable]);
      final result = await repo.getWatchlistTv();
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTv]);
    });
  });
}
