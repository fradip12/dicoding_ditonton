import 'package:bloc_test/bloc_test.dart';
import 'package:common/common.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/series.dart';

import 'series_list_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvNowPlayingMovies,
  GetTvPopular,
  GetTvTopRated,
])
void main() {
  late MockGetTvNowPlayingMovies mockGetTvNowPlayingMovies;
  late MockGetTvPopular mockGetTvPopular;
  late MockGetTvTopRated mockGetTvTopRated;
  late TvListBloc bloc;
  setUp(() {
    mockGetTvNowPlayingMovies = MockGetTvNowPlayingMovies();
    mockGetTvPopular = MockGetTvPopular();
    mockGetTvTopRated = MockGetTvTopRated();
    bloc = TvListBloc(
      mockGetTvNowPlayingMovies,
      mockGetTvPopular,
      mockGetTvTopRated,
    );
  });
  final tTvList = <TV>[];

  group("On Load All", () {
    test('initialState should be Empty', () {
      expect(bloc.state, TvListInitial());
      expect(bloc.nowPlayingState, equals(RequestState.Empty));
      expect(bloc.nowPlayingMovies, equals(<TV>[]));

      expect(bloc.popularState, equals(RequestState.Empty));
      expect(bloc.popularMovies, equals(<TV>[]));

      expect(bloc.topRatedState, equals(RequestState.Empty));
      expect(bloc.topRatedMovies, equals(<TV>[]));
    });

    blocTest<TvListBloc, TvListState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTvNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tTvList));
        when(mockGetTvPopular.execute())
            .thenAnswer((_) async => Right(tTvList));
        when(mockGetTvTopRated.execute())
            .thenAnswer((_) async => Right(tTvList));
        return bloc;
      },
      act: (bloc) => bloc.add(OnLoadTvList()),
      expect: () => [
        TvListLoading(),
        TvListLoaded(
          tTvList,
          tTvList,
          tTvList,
          RequestState.Loaded,
          RequestState.Loaded,
          RequestState.Loaded,
        ),
      ],
      verify: (bloc) {
        verify(mockGetTvNowPlayingMovies.execute());
        verify(mockGetTvPopular.execute());
        verify(mockGetTvTopRated.execute());
      },
    );

    blocTest<TvListBloc, TvListState>(
      'Should emit [Loading, No Data] when data is gotten unsuccessfully',
      build: () {
        when(mockGetTvNowPlayingMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(mockGetTvPopular.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        when(mockGetTvTopRated.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc.add(OnLoadTvList()),
      expect: () => [
        TvListLoading(),
        TvListError('Server Failure')
      ],
      verify: (bloc) {
        verify(mockGetTvNowPlayingMovies.execute());
        verify(mockGetTvPopular.execute());
        verify(mockGetTvTopRated.execute());
      },
    );
  });
}
