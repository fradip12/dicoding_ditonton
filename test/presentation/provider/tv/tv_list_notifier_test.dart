import 'package:dartz/dartz.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_now_playing.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_popular.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_toprated.dart';
import 'package:ditonton/presentation/provider/tv/tv_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvNowPlayingMovies,
  GetTvPopular,
  GetTvTopRated,
])
void main() {
  late TvListNotifier provider;
  late MockGetTvNowPlayingMovies mockGetTvNowPlayingMovies;
  late MockGetTvPopular mockGetTvPopular;
  late MockGetTvTopRated mockGetTvTopRated;
  late int listenerCallCount;
  setUp(() {
    listenerCallCount = 0;
    mockGetTvNowPlayingMovies = MockGetTvNowPlayingMovies();
    mockGetTvPopular = MockGetTvPopular();
    mockGetTvTopRated = MockGetTvTopRated();
    provider = TvListNotifier(
      getNowPlayingTv: mockGetTvNowPlayingMovies,
      getTvPopular: mockGetTvPopular,
      getTvToprated: mockGetTvTopRated,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });
  final tTvList = <TV>[];

  // now playing tv series
  group("now playing tv series", () {
    test("initialState should be empty", () {
      expect(provider.nowPlayingState, equals(RequestState.Empty));
    });

    test("should get data from the usecase", () async {
      when(mockGetTvNowPlayingMovies.execute())
          .thenAnswer((realInvocation) async => Right(tTvList));
      provider.fetchNowPlayingMovies();
      verify(mockGetTvNowPlayingMovies.execute());
    });

    test("should change state to loading when usecase is called", () async {
      when(mockGetTvNowPlayingMovies.execute())
          .thenAnswer((realInvocation) async => Right(tTvList));
      provider.fetchNowPlayingMovies();
      expect(provider.nowPlayingState, RequestState.Loading);
    });
    test("shhould change movies when data success", () async {
      when(mockGetTvNowPlayingMovies.execute())
          .thenAnswer((realInvocation) async => Right(tTvList));
      await provider.fetchNowPlayingMovies();
      expect(provider.nowPlayingMovies, tTvList);
      expect(listenerCallCount, 2);
    });
    test("shhould change state to loaded when data success", () async {
      when(mockGetTvNowPlayingMovies.execute())
          .thenAnswer((realInvocation) async => Right(tTvList));
      await provider.fetchNowPlayingMovies();
      expect(provider.nowPlayingState, equals(RequestState.Loaded));
    });
  });

  //top rated
  group("top rated tv series", () {
    test("initialState should be empty", () {
      expect(provider.topRatedMoviesState, equals(RequestState.Empty));
    });

    test("should get data from the usecase", () async {
      when(mockGetTvTopRated.execute())
          .thenAnswer((realInvocation) async => Right(tTvList));
      provider.fetchTopRatedMovies();
      verify(mockGetTvTopRated.execute());
    });

    test("should change state to loading when usecase is called", () async {
      when(mockGetTvTopRated.execute())
          .thenAnswer((realInvocation) async => Right(tTvList));
      provider.fetchTopRatedMovies();
      expect(provider.topRatedMoviesState, RequestState.Loading);
    });
    test("shhould change movies when data success", () async {
      when(mockGetTvTopRated.execute())
          .thenAnswer((realInvocation) async => Right(tTvList));
      await provider.fetchTopRatedMovies();
      expect(provider.topRatedMovies, tTvList);
      expect(listenerCallCount, 2);
    });
    test("shhould change state to loaded when data success", () async {
      when(mockGetTvTopRated.execute())
          .thenAnswer((realInvocation) async => Right(tTvList));
      await provider.fetchTopRatedMovies();
      expect(provider.topRatedMoviesState, equals(RequestState.Loaded));
    });
  });

  //popular
  group("popular tv series", () {
    test("initialState should be empty", () {
      expect(provider.popularMoviesState, equals(RequestState.Empty));
    });

    test("should get data from the usecase", () async {
      when(mockGetTvPopular.execute())
          .thenAnswer((realInvocation) async => Right(tTvList));
      provider.fetchPopularMovies();
      verify(mockGetTvPopular.execute());
    });

    test("should change state to loading when usecase is called", () async {
      when(mockGetTvPopular.execute())
          .thenAnswer((realInvocation) async => Right(tTvList));
      provider.fetchPopularMovies();
      expect(provider.popularMoviesState, RequestState.Loading);
    });
    test("shhould change movies when data success", () async {
      when(mockGetTvPopular.execute())
          .thenAnswer((realInvocation) async => Right(tTvList));
      await provider.fetchPopularMovies();
      expect(provider.nowPlayingMovies, tTvList);
      expect(listenerCallCount, 2);
    });
    test("shhould change state to loaded when data success", () async {
      when(mockGetTvPopular.execute())
          .thenAnswer((realInvocation) async => Right(tTvList));
      await provider.fetchPopularMovies();
      expect(provider.popularMoviesState, equals(RequestState.Loaded));
    });
  });
}
