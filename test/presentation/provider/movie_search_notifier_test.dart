import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/tv/search_tv.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_search_notifier_test.mocks.dart';

@GenerateMocks([SearchMovies, SearchSeries])
void main() {
  late MovieSearchNotifier provider;
  late MockSearchMovies mockSearchMovies;
  late MockSearchSeries mockSearchSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchMovies = MockSearchMovies();
    mockSearchSeries = MockSearchSeries();
    provider = MovieSearchNotifier(
      searchMovies: mockSearchMovies,
      searchSeries: mockSearchSeries,
    )..addListener(() {
        listenerCallCount += 1;
      });
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
  final tQuery = 'spiderman';

  final tTvModel = TV(
      backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
      genreIds: [14, 28],
      id: 557,
      overview:
          'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
      popularity: 60.441,
      posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
      voteAverage: '7.2',
      firstAirDate: '',
      name: 'spiderman',
      voteCount: 13507,
      originCountry: ['id'],
      originalLanguage: 'id',
      originalName: 'spiderman');
  final tTvList = <TV>[tTvModel];
  final tTvQuery = 'spiderman';

  group('search movies', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(tMovieList));
      // act
      provider.fetchMovieSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(tMovieList));
      // act
      await provider.fetchMovieSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.searchResult, tMovieList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchMovieSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
  group('search series', () {
    test('should change state to loading when usecase is called', () async {
      when(mockSearchSeries.execute(tTvQuery))
          .thenAnswer((_) async => Right(tTvList));
      provider.fetchTVSearch(tTvQuery);
      expect(provider.state, RequestState.Loading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      when(mockSearchSeries.execute(tTvQuery))
          .thenAnswer((_) async => Right(tTvList));
      await provider.fetchTVSearch(tTvQuery);
      expect(provider.state, RequestState.Loaded);
      expect(provider.searchTVResult, tTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      when(mockSearchSeries.execute(tTvQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      await provider.fetchTVSearch(tTvQuery);
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
