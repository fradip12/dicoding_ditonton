import 'package:bloc_test/bloc_test.dart';
import 'package:common/common.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/series.dart';
import 'package:watchlist/watchlist.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'series_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
  GetTvWatchListStatus,
  SaveTvWatchlist,
  RemoveTvWatchlist,
])
void main() {
  late MockGetTvDetail mockgetTvDetail;
  late MockGetTvRecommendations mockgetTvRecommendations;
  late MockSaveTvWatchlist mocksaveTvWatchlist;
  late MockRemoveTvWatchlist mockremoveTvWatchlist;
  late MockGetTvWatchListStatus mockgetTvWatchListStatus;
  late TvDetailBloc bloc;
  setUp(() {
    mockgetTvDetail = MockGetTvDetail();
    mockgetTvRecommendations = MockGetTvRecommendations();
    mocksaveTvWatchlist = MockSaveTvWatchlist();
    mockgetTvWatchListStatus = MockGetTvWatchListStatus();
    mockremoveTvWatchlist = MockRemoveTvWatchlist();
    bloc = TvDetailBloc(
      getTvDetail: mockgetTvDetail,
      getTvRecommendations: mockgetTvRecommendations,
      getTvWatchListStatus: mockgetTvWatchListStatus,
      removeTvWatchlist: mockremoveTvWatchlist,
      saveTvWatchlist: mocksaveTvWatchlist,
    );
  });


  group("bloc", () {
    test('initial state should be empty', () {
      expect(bloc.state, TvDetailEmpty());
    });
  });
  group("on detail load", () {
    blocTest<TvDetailBloc, TvDetailState>(
      'Should emit [Error, No Data] when data is gotten unsuccessfully',
      build: () {
        when(mockgetTvDetail.execute(1))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(mockgetTvRecommendations.execute(1))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(mockgetTvWatchListStatus.execute(1)).thenAnswer((_) async => false);
        return bloc;
      },
      act: (bloc) => bloc.add(OnTvDetailLoad(1)),
      expect: () => [
        TvDetailLoading(),
        TvDetailError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockgetTvDetail.execute(1));
        verify(mockgetTvRecommendations.execute(1));
        verify(mockgetTvWatchListStatus.execute(1));
      },
    );
    group("watchlist on", () {
      setUp(() {
        when(mockgetTvWatchListStatus.execute(1)).thenAnswer((_) async => true);
      });
      blocTest<TvDetailBloc, TvDetailState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockgetTvDetail.execute(1))
              .thenAnswer((_) async => Right(testTvDetail));
          when(mockgetTvRecommendations.execute(1))
              .thenAnswer((_) async => Right([tSeriesModel]));
          return bloc;
        },
        act: (bloc) => bloc.add(OnTvDetailLoad(1)),
        expect: () => [
          TvDetailLoading(),
          TvDetailLoaded(testTvDetail, [tSeriesModel], true),
        ],
        verify: (bloc) {
          verify(mockgetTvDetail.execute(1));
          verify(mockgetTvRecommendations.execute(1));
          verify(mockgetTvWatchListStatus.execute(1));
        },
      );
    });
    group("watchlist off", () {
      setUp(() {
        when(mockgetTvWatchListStatus.execute(1)).thenAnswer((_) async => false);
      });
      blocTest<TvDetailBloc, TvDetailState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockgetTvDetail.execute(1))
              .thenAnswer((_) async => Right(testTvDetail));
          when(mockgetTvRecommendations.execute(1))
              .thenAnswer((_) async => Right([tSeriesModel]));
          return bloc;
        },
        act: (bloc) => bloc.add(OnTvDetailLoad(1)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          TvDetailLoading(),
          TvDetailLoaded(testTvDetail, [tSeriesModel], false),
        ],
        verify: (bloc) {
          verify(mockgetTvDetail.execute(1));
          verify(mockgetTvRecommendations.execute(1));
          verify(mockgetTvWatchListStatus.execute(1));
        },
      );
    });
  });

  group("on add to watchlist", () {
    setUp(() {
      when(mockgetTvDetail.execute(1))
          .thenAnswer((_) async => Right(testTvDetail));
      when(mockgetTvRecommendations.execute(1))
          .thenAnswer((_) async => Right([tSeriesModel]));
      when(mockgetTvWatchListStatus.execute(1)).thenAnswer((_) async => true);
    });
    blocTest<TvDetailBloc, TvDetailState>(
      'should emit WatchlistDialog when add to watchlist success',
      build: () {
        when(mocksaveTvWatchlist.execute(testTvDetail))
            .thenAnswer((_) async => Right('Added to watchlist'));
        return bloc;
      },
      act: (bloc) => bloc.add(OnAddTvtoWatchlist(testTvDetail)),
      expect: () => [
        WatchlistTvDialog('Added to watchlist'),
        TvDetailLoading(),
        TvDetailLoaded(testTvDetail, [tSeriesModel], true),
      ],
      verify: (bloc) {
        verify(mockgetTvDetail.execute(1));
        verify(mockgetTvRecommendations.execute(1));
        verify(mockgetTvWatchListStatus.execute(1));
      },
    );
  });

  group("on remove watchlist", () {
    final detail = testTvDetail;
    setUp(() {
      when(mockgetTvDetail.execute(1))
          .thenAnswer((_) async => Right(detail));
      when(mockgetTvRecommendations.execute(1))
          .thenAnswer((_) async => Right([tSeriesModel]));
      when(mockgetTvWatchListStatus.execute(1)).thenAnswer((_) async => false);
    });
    blocTest<TvDetailBloc, TvDetailState>(
      'should emit WatchlistDialog when remove watchlist success',
      build: () {
        when(mockremoveTvWatchlist.execute(detail))
            .thenAnswer((_) async => Right('Removed from watchlist'));
        return bloc;
      },
      act: (bloc) => bloc.add(OnTvRemoveWatchlist(detail)),
      expect: () => [
        WatchlistTvDialog('Removed from watchlist'),
        TvDetailLoading(),
        TvDetailLoaded(testTvDetail, [tSeriesModel], false),
      ],
      verify: (bloc) {
        verify(mockgetTvDetail.execute(1));
        verify(mockgetTvRecommendations.execute(1));
        verify(mockgetTvWatchListStatus.execute(1));
      },
    );
  });


}
