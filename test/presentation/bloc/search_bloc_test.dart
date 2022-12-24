import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecase/search_movies.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:dartz/dartz.dart';
import 'search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies, SearchSeries])
void main() {
  late SearchBloc searchBloc;
  late MockSearchMovies mockSearchMovies;
  late MockSearchSeries mockSearchSeries;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    mockSearchSeries = MockSearchSeries();
    searchBloc = SearchBloc(mockSearchMovies, mockSearchSeries);
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];
  final tSeriesModel = TV(
    backdropPath: 'backdropPath',
    id: 1,
    originalLanguage: 'en',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: '1',
    voteCount: 1,
    name: 'name',
    originCountry: ['id'],
    originalName: 'name',
    genreIds: [1],
    firstAirDate: '01-01-22',
  );
  final tSeriesList = <TV>[tSeriesModel];
  final tQuery = 'spiderman';
  late SearchType type;
  group("search movies", () {
    setUp(() {
      type = SearchType.MOVIES;
    });
    test('initial state should be empty', () {
      expect(searchBloc.state, SearchEmpty());
    });

    blocTest<SearchBloc, SearchState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Right(tMovieList));
        return searchBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQuery, type)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        SearchHasData(tMovieList),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );

    blocTest<SearchBloc, SearchState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return searchBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQuery, type)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        SearchError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );
  });

  group("search series", () {
    setUp(() {
      type = SearchType.TVSERIES;
    });
    test('initial state should be empty', () {
      expect(searchBloc.state, SearchEmpty());
    });

    blocTest<SearchBloc, SearchState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSearchSeries.execute(tQuery))
            .thenAnswer((_) async => Right(tSeriesList));
        return searchBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQuery, type)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        SearchTvHasData(tSeriesList),
      ],
      verify: (bloc) {
        verify(mockSearchSeries.execute(tQuery));
      },
    );

    blocTest<SearchBloc, SearchState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockSearchSeries.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return searchBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQuery, type)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        SearchError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSearchSeries.execute(tQuery));
      },
    );
  });
}
