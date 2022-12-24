import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:core/core.dart';
import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies, GetTvWatchlistMovies])
void main() {
  late WatchlistMovieNotifier provider;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetTvWatchlistMovies mockGetTvWatchlistMovies;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetTvWatchlistMovies = MockGetTvWatchlistMovies();
    provider = WatchlistMovieNotifier(
      getWatchlistMovies: mockGetWatchlistMovies,
      getTvWatchlist: mockGetTvWatchlistMovies,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  group("watchlist movies", () {
    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right([testWatchlistMovie]));
      // act
      await provider.fetchWatchlistMovies();
      // assert
      expect(provider.watchlistState, RequestState.Loaded);
      expect(provider.watchlistMovies, [testWatchlistMovie]);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
      // act
      await provider.fetchWatchlistMovies();
      // assert
      expect(provider.watchlistState, RequestState.Error);
      expect(provider.message, "Can't get data");
      expect(listenerCallCount, 2);
    });
  });
  group("watchlist series", () {
    test('should change tv data when data is gotten successfully', () async {
      when(mockGetTvWatchlistMovies.execute())
          .thenAnswer((_) async => Right([testWatchlistTv]));
      await provider.fetchWatchlistTv();
      expect(provider.watchlistTvState, RequestState.Loaded);
      expect(provider.watchlistTV, [testWatchlistTv]);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      when(mockGetTvWatchlistMovies.execute())
          .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
      await provider.fetchWatchlistTv();
      expect(provider.watchlistTvState, RequestState.Error);
      expect(provider.message, "Can't get data");
      expect(listenerCallCount, 2);
    });
  });
}
