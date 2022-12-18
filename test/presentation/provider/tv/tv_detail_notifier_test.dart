import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_watchlist_status.dart';
import 'package:ditonton/domain/usecases/tv/tv_remove_watchlist.dart';
import 'package:ditonton/domain/usecases/tv/tv_save_watchlist.dart';
import 'package:ditonton/presentation/provider/tv/tv_detail_notifider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
  SaveTvWatchlist,
  RemoveTvWatchlist,
  GetTvWatchListStatus,
])
void main() {
  late MockGetTvDetail mockgetTvDetail;
  late MockGetTvRecommendations mockgetTvRecommendations;
  late MockSaveTvWatchlist mocksaveTvWatchlist;
  late MockRemoveTvWatchlist mockremoveTvWatchlist;
  late MockGetTvWatchListStatus mockgetTvWatchListStatus;
  late TvDetailNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockgetTvDetail = MockGetTvDetail();
    mockgetTvRecommendations = MockGetTvRecommendations();
    mocksaveTvWatchlist = MockSaveTvWatchlist();
    mockgetTvWatchListStatus = MockGetTvWatchListStatus();
    mockremoveTvWatchlist = MockRemoveTvWatchlist();
    notifier = TvDetailNotifier(
      getTvDetail: mockgetTvDetail,
      getTvRecommendations: mockgetTvRecommendations,
      getTvWatchListStatus: mockgetTvWatchListStatus,
      removeTvWatchlist: mockremoveTvWatchlist,
      saveTvWatchlist: mocksaveTvWatchlist,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tId = 1;
  final tMovies = <TV>[testTv];

  void arrangeUsecase() {
    when(mockgetTvDetail.execute(tId))
        .thenAnswer((_) async => Right(testTvDetail));
    when(mockgetTvRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tMovies));
  }

  group('Detail', () {
    test('should get data from the usecase', () async {
      arrangeUsecase();
      await notifier.fetchMovieDetail(tId);
      verify(mockgetTvDetail.execute(tId));
      verify(mockgetTvRecommendations.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      arrangeUsecase();
      notifier.fetchMovieDetail(tId);
      expect(notifier.movieState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv series when data is gotten successfully', () async {
      arrangeUsecase();
      await notifier.fetchMovieDetail(tId);
      expect(notifier.movieState, RequestState.Loaded);
      expect(notifier.movie, testTvDetail);
      expect(listenerCallCount, 3);
    });

    test('should change recommendation movies when data is gotten successfully',
        () async {
      arrangeUsecase();
      await notifier.fetchMovieDetail(tId);
      expect(notifier.movieState, RequestState.Loaded);
      expect(notifier.tvRecommendations, tMovies);
    });
  });
  group('Recommendations', () {
    test('should get data from the usecase', () async {
      arrangeUsecase();
      await notifier.fetchMovieDetail(tId);
      verify(mockgetTvRecommendations.execute(tId));
      expect(notifier.tvRecommendations, [testTv]);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      arrangeUsecase();
      await notifier.fetchMovieDetail(tId);
      expect(notifier.recommendationState, RequestState.Loaded);
      expect(notifier.tvRecommendations, tMovies);
    });

    test('should update error message when request in successful', () async {
      when(mockgetTvDetail.execute(tId))
          .thenAnswer((_) async => Right(testTvDetail));
      when(mockgetTvRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      await notifier.fetchMovieDetail(tId);
      expect(notifier.recommendationState, RequestState.Error);
      expect(notifier.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      when(mockgetTvWatchListStatus.execute(1)).thenAnswer((_) async => true);
      await notifier.loadWatchlistStatus(1);
      expect(notifier.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      when(mocksaveTvWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockgetTvWatchListStatus.execute(testMovieDetail.id))
          .thenAnswer((_) async => true);
      await notifier.addWatchlist(testTvDetail);
      verify(mocksaveTvWatchlist.execute(testTvDetail));
    });

    test('should execute remove watchlist when function called', () async {
      when(mockremoveTvWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockgetTvWatchListStatus.execute(testMovieDetail.id))
          .thenAnswer((_) async => false);
      await notifier.removeFromWatchlist(testTvDetail);
      verify(mockremoveTvWatchlist.execute(testTvDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      when(mocksaveTvWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockgetTvWatchListStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => true);
      await notifier.addWatchlist(testTvDetail);
      verify(mockgetTvWatchListStatus.execute(testTvDetail.id));
      expect(notifier.isAddedToWatchlist, true);
      expect(notifier.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      when(mocksaveTvWatchlist.execute(testTvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockgetTvWatchListStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => false);
      await notifier.addWatchlist(testTvDetail);
      expect(notifier.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });
  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      when(mockgetTvDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockgetTvRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tMovies));
      await notifier.fetchMovieDetail(tId);
      expect(notifier.movieState, RequestState.Error);
      expect(notifier.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
