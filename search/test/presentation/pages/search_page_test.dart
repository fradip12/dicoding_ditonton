import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';
import 'package:search/search.dart';
import 'package:series/series.dart';

import 'search_page_test.mocks.dart';

@GenerateMocks([SearchBloc])
void main() {
  late MockSearchBloc bloc;
  setUp(() {
    bloc = MockSearchBloc();
  });

  Widget _makeTestableWidgetMovies() {
    return BlocProvider<SearchBloc>.value(
      value: bloc,
      child: MaterialApp(
        home: Scaffold(
          body: SearchPage(
            type: SearchType.movies,
          ),
        ),
      ),
    );
  }

  Widget _makeTestableWidgetSeries() {
    return BlocProvider<SearchBloc>.value(
      value: bloc,
      child: MaterialApp(
        home: Scaffold(
          body: SearchPage(
            type: SearchType.tvSeries,
          ),
        ),
      ),
    );
  }

  group("Search Movies", () {
    group("state is loading", () {
      setUp(() {
        final expected = SearchLoading();
        when(bloc.state).thenReturn(expected);
        when(bloc.stream).thenAnswer((_) => Stream.value(expected));
      });
      testWidgets(
        "App bar widget test",
        (widgetTester) async {
          await widgetTester.pumpWidget(_makeTestableWidgetMovies());
          expect(find.text('Search Movies'), findsOneWidget);
        },
      );
      testWidgets('Page should display Container bar when state is empty',
          (WidgetTester tester) async {
        final centerFinder = find.byType(
          CircularProgressIndicator,
        );
        await tester.pumpWidget(_makeTestableWidgetMovies());
        expect(centerFinder, findsWidgets);
      });
    });

    group("search has Data", () {
      final testMovie = Movie(
        adult: false,
        backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
        genreIds: [14, 28],
        id: 1,
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

      final testMovieList = [testMovie];
      final expected = SearchHasData(testMovieList);
      setUp(() {
        when(bloc.state).thenReturn(expected);
        when(bloc.stream).thenAnswer((_) => Stream.value(expected));
      });

      testWidgets('should display listview and movie card when data is loaded',
          (WidgetTester tester) async {
        final finder = find.byType(
          ListView,
        );
        final finderCard = find.byType(
          ListView,
        );
        await tester.pumpWidget(_makeTestableWidgetMovies());
        expect(finder, findsWidgets);
        expect(finderCard, findsWidgets);
      });
    });

    group("search state error", () {
      setUp(() {
        final expected = SearchError('Failed');

        when(bloc.state).thenReturn(expected);
        when(bloc.stream).thenAnswer((_) => Stream.value(expected));
      });

      testWidgets(
        "Text test failed",
        (widgetTester) async {
          await widgetTester.pumpWidget(_makeTestableWidgetMovies());
          expect(find.text('Failed'), findsOneWidget);
        },
      );
    });
    group("search state empty", () {
      setUp(() {
        final expected = SearchEmpty();

        when(bloc.state).thenReturn(expected);
        when(bloc.stream).thenAnswer((_) => Stream.value(expected));
      });

      testWidgets(
        "should display container",
        (widgetTester) async {
          await widgetTester.pumpWidget(_makeTestableWidgetMovies());
          expect(find.byType(Container), findsOneWidget);
        },
      );
    });
  });

  group("Search Series", () {
    final testTv = TV(
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

    final testTvList = [testTv];
    group("state is loading", () {
      setUp(() {
        final expected = SearchLoading();
        when(bloc.state).thenReturn(expected);
        when(bloc.stream).thenAnswer((_) => Stream.value(expected));
      });
      testWidgets(
        "App bar widget test",
        (widgetTester) async {
          await widgetTester.pumpWidget(_makeTestableWidgetSeries());
          expect(find.text('Search Series'), findsOneWidget);
        },
      );
      testWidgets('Page should display Container bar when state is empty',
          (WidgetTester tester) async {
        final centerFinder = find.byType(
          CircularProgressIndicator,
        );
        await tester.pumpWidget(_makeTestableWidgetSeries());
        expect(centerFinder, findsWidgets);
      });
    });

    group("search has Data", () {
     
      final expected = SearchTvHasData(testTvList);
      setUp(() {
        when(bloc.state).thenReturn(expected);
        when(bloc.stream).thenAnswer((_) => Stream.value(expected));
      });

      testWidgets('should display listview and movie card when data is loaded',
          (WidgetTester tester) async {
        final finder = find.byType(
          ListView,
        );
        final finderCard = find.byType(
          ListView,
        );
        await tester.pumpWidget(_makeTestableWidgetSeries());
        expect(finder, findsWidgets);
        expect(finderCard, findsWidgets);
      });
    });

    group("search state error", () {
      setUp(() {
        final expected = SearchError('Failed');

        when(bloc.state).thenReturn(expected);
        when(bloc.stream).thenAnswer((_) => Stream.value(expected));
      });

      testWidgets(
        "Text test failed",
        (widgetTester) async {
          await widgetTester.pumpWidget(_makeTestableWidgetSeries());
          expect(find.text('Failed'), findsOneWidget);
        },
      );
    });
    group("search state empty", () {
      setUp(() {
        final expected = SearchEmpty();

        when(bloc.state).thenReturn(expected);
        when(bloc.stream).thenAnswer((_) => Stream.value(expected));
      });

      testWidgets(
        "should display container",
        (widgetTester) async {
          await widgetTester.pumpWidget(_makeTestableWidgetSeries());
          expect(find.byType(Container), findsOneWidget);
        },
      );
    });
  });
}
