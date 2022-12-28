import 'package:bloc_test/bloc_test.dart';
import 'package:common/common.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/features/movies/domain/usecases/get_movie_detail.dart';
import 'package:movies/features/movies/domain/usecases/get_movie_recommendations.dart';
import 'package:movies/features/movies/presentation/bloc/movie/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:movies/features/movies/presentation/bloc/movie/movie_list_bloc/movie_list_bloc.dart';
import 'package:watchlist/domain/usecases/movie/get_watchlist_status.dart';
import 'package:watchlist/domain/usecases/movie/remove_watchlist.dart';
import 'package:watchlist/domain/usecases/movie/save_watchlist.dart';
import 'package:dartz/dartz.dart';
import '../../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist
])
void main() {
  late MovieDetailBloc bloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    bloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      getWatchListStatus: mockGetWatchListStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  group("bloc", () {
    test('initial state should be empty', () {
      expect(bloc.state, MovieDetailEmpty());
    });
  });
  group("on detail load", () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Error, No Data] when data is gotten unsuccessfully',
      build: () {
        when(mockGetMovieDetail.execute(1))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(mockGetMovieRecommendations.execute(1))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(mockGetWatchListStatus.execute(1)).thenAnswer((_) async => false);
        return bloc;
      },
      act: (bloc) => bloc.add(OnDetailLoad(1)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        MovieDetailLoading(),
        MovieDetailError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(1));
        verify(mockGetMovieRecommendations.execute(1));
        verify(mockGetWatchListStatus.execute(1));
      },
    );
    group("watchlist on", () {
      setUp(() {
        when(mockGetWatchListStatus.execute(1)).thenAnswer((_) async => true);
      });
      blocTest<MovieDetailBloc, MovieDetailState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetMovieDetail.execute(1))
              .thenAnswer((_) async => Right(testMovieDetail));
          when(mockGetMovieRecommendations.execute(1))
              .thenAnswer((_) async => Right([tMovieModel]));
          return bloc;
        },
        act: (bloc) => bloc.add(OnDetailLoad(1)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          MovieDetailLoading(),
          MovieDetailLoaded(testMovieDetail, [tMovieModel], true),
        ],
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(1));
          verify(mockGetMovieRecommendations.execute(1));
          verify(mockGetWatchListStatus.execute(1));
        },
      );
    });
    group("watchlist off", () {
      setUp(() {
        when(mockGetWatchListStatus.execute(1)).thenAnswer((_) async => false);
      });
      blocTest<MovieDetailBloc, MovieDetailState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetMovieDetail.execute(1))
              .thenAnswer((_) async => Right(testMovieDetail));
          when(mockGetMovieRecommendations.execute(1))
              .thenAnswer((_) async => Right([tMovieModel]));
          return bloc;
        },
        act: (bloc) => bloc.add(OnDetailLoad(1)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          MovieDetailLoading(),
          MovieDetailLoaded(testMovieDetail, [tMovieModel], false),
        ],
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(1));
          verify(mockGetMovieRecommendations.execute(1));
          verify(mockGetWatchListStatus.execute(1));
        },
      );
    });
  });

  group("on add to watchlist", () {
    final detail = testMovieDetail;
    setUp(() {
      when(mockGetMovieDetail.execute(1))
          .thenAnswer((_) async => Right(testMovieDetail));
      when(mockGetMovieRecommendations.execute(1))
          .thenAnswer((_) async => Right([tMovieModel]));
      when(mockGetWatchListStatus.execute(1)).thenAnswer((_) async => true);
    });
    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emit WatchlistDialog when add to watchlist success',
      build: () {
        when(mockSaveWatchlist.execute(detail))
            .thenAnswer((_) async => Right('Added to watchlist'));
        return bloc;
      },
      act: (bloc) => bloc.add(OnAddtoWatchlist(detail)),
      expect: () => [
        WatchlistDialog('Added to watchlist'),
        MovieDetailLoading(),
        MovieDetailLoaded(testMovieDetail, [tMovieModel], true),
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(1));
        verify(mockGetMovieRecommendations.execute(1));
        verify(mockGetWatchListStatus.execute(1));
      },
    );
  });

  group("on remove watchlist", () {
    final detail = testMovieDetail;
    setUp(() {
      when(mockGetMovieDetail.execute(1))
          .thenAnswer((_) async => Right(testMovieDetail));
      when(mockGetMovieRecommendations.execute(1))
          .thenAnswer((_) async => Right([tMovieModel]));
      when(mockGetWatchListStatus.execute(1)).thenAnswer((_) async => false);
    });
    blocTest<MovieDetailBloc, MovieDetailState>(
      'should emit WatchlistDialog when remove watchlist success',
      build: () {
        when(mockRemoveWatchlist.execute(detail))
            .thenAnswer((_) async => Right('Removed from watchlist'));
        return bloc;
      },
      act: (bloc) => bloc.add(OnRemoveWatchlist(detail)),
      expect: () => [
        WatchlistDialog('Removed from watchlist'),
        MovieDetailLoading(),
        MovieDetailLoaded(testMovieDetail, [tMovieModel], false),
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(1));
        verify(mockGetMovieRecommendations.execute(1));
        verify(mockGetWatchListStatus.execute(1));
      },
    );
  });
}
