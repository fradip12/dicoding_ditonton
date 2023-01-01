import 'package:bloc_test/bloc_test.dart';
import 'package:common/common.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/watchlist.dart';
import 'package:dartz/dartz.dart';
import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies, GetTvWatchlistMovies])
void main() {
  late WatchlistBloc watchlistBloc;
  late MockGetTvWatchlistMovies mockGetTvWatchlistMovies;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetTvWatchlistMovies = MockGetTvWatchlistMovies();
    watchlistBloc = WatchlistBloc(
      getWatchlistMovies: mockGetWatchlistMovies,
      getTvWatchlist: mockGetTvWatchlistMovies,
    );
  });
 
  group("get watchlist movies and series", () {
    test('initial state should be empty', () {
      expect(watchlistBloc.state, WatchlistEmpty());
    });

    blocTest<WatchlistBloc, WatchlistState>(
      'Should emit [Empty,Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        when(mockGetTvWatchlistMovies.execute())
            .thenAnswer((_) async => Right(tSeriesList));
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(OnLoadWatchlist()),
      expect: () => [
        WatchlistLoading(),
        WatchlistLoaded(
          watchlistMovies: tMovieList,
          watchlistMoviesState: RequestState.loaded,
          watchlistSeries: tSeriesList,
          watchlistSeriesState: RequestState.loaded,
        ),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
        verify(mockGetTvWatchlistMovies.execute());
      },
    );

    blocTest<WatchlistBloc, WatchlistState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(mockGetTvWatchlistMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(OnLoadWatchlist()),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        WatchlistLoading(),
        WatchlistError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
        verify(mockGetTvWatchlistMovies.execute());
      },
    );
  });
}
