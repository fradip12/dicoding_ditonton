import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/features/movies/presentation/widgets/movie_card_list.dart';
import 'package:watchlist/watchlist.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movies_page_test.mocks.dart';

@GenerateMocks([WatchlistBloc])
void main() {
  late MockWatchlistBloc bloc;
  setUp(() {
    bloc = MockWatchlistBloc();
  });

  Widget _makeTestableWidget() {
    return BlocProvider<WatchlistBloc>.value(
      value: bloc,
      child: MaterialApp(
        home: Scaffold(body: WatchlistMoviesPage()),
      ),
    );
  }

  //   testWidgets(
  //   "while tap on series tab bar should display Tabbar View",
  //   (widgetTester) async {
  //     await widgetTester.pumpWidget(_makeTestableWidget());
  //     final tab = find.widgetWithText(Tab, 'TV Series');
  //     await widgetTester.tap(tab);
  //     await widgetTester.pump();
  //     expect(find.byType(TabBarView), findsOneWidget);
  //   },
  // );

  group("movies tab widget test", () {
    group("check tab bar", () {
      setUp(() {
        final expected = WatchlistEmpty();
        when(bloc.state).thenReturn(expected);
        when(bloc.stream).thenAnswer((_) => Stream.value(expected));
      });

      testWidgets(
        "Should display tab bar",
        (widgetTester) async {
          await widgetTester.pumpWidget(_makeTestableWidget());
          expect(find.widgetWithText(Tab, 'Movies'), findsOneWidget);
        },
      );

      testWidgets(
        "while tap on movies tab bar should display Tabbar View",
        (widgetTester) async {
          await widgetTester.pumpWidget(_makeTestableWidget());
          final tab = find.widgetWithText(Tab, 'Movies');
          await widgetTester.tap(tab);
          await widgetTester.pump();
          expect(find.byType(TabBarView), findsOneWidget);
        },
      );
    });

    group("when state is empty", () {
      setUp(() {
        final expected = WatchlistEmpty();
        when(bloc.state).thenReturn(expected);
        when(bloc.stream).thenAnswer((_) => Stream.value(expected));
      });
      testWidgets(
        "App bar widget test",
        (widgetTester) async {
          await widgetTester.pumpWidget(_makeTestableWidget());
          expect(find.text('Watchlist'), findsOneWidget);
        },
      );
      testWidgets('Page should display Container bar when state is empty',
          (WidgetTester tester) async {
        final centerFinder = find.byType(
          Container,
        );
        await tester.pumpWidget(_makeTestableWidget());
        expect(centerFinder, findsWidgets);
      });
    });

    group("when state is loading", () {
      setUp(() {
        final expected = WatchlistLoading();
        when(bloc.state).thenReturn(expected);
        when(bloc.stream).thenAnswer((_) => Stream.value(expected));
      });
      testWidgets('Page should display Container bar when state is empty',
          (WidgetTester tester) async {
        final progressFinder = find.byType(
          CircularProgressIndicator,
        );
        final centerFinder = find.byType(
          CircularProgressIndicator,
        );
        await tester.pumpWidget(_makeTestableWidget());
        expect(progressFinder, findsWidgets);
        expect(centerFinder, findsWidgets);
      });
    });

    group("when state is loaded", () {
      setUp(() {
        final expected = WatchlistLoaded(
          watchlistMovies: testMovieList,
          watchlistMoviesState: RequestState.loaded,
          watchlistSeries: testTvList,
          watchlistSeriesState: RequestState.loaded,
        );
        when(bloc.state).thenReturn(expected);
        when(bloc.stream).thenAnswer((_) => Stream.value(expected));
      });
      testWidgets('should display listview', (WidgetTester tester) async {
        final finder = find.byType(
          ListView,
        );
        await tester.pumpWidget(_makeTestableWidget());
        expect(finder, findsWidgets);
      });
      testWidgets('should display movie card', (WidgetTester tester) async {
        await tester.pumpWidget(_makeTestableWidget());
        final finder = find.byType(
          MovieCard,
        );
        expect(finder, findsWidgets);
      });
    });

    group(" when state is error", () {
      setUp(() {
        final expected = WatchlistError('Error');
        when(bloc.state).thenReturn(expected);
        when(bloc.stream).thenAnswer((_) => Stream.value(expected));
      });
      testWidgets('should display text error', (WidgetTester tester) async {
        final finder = find.text(
          'Error',
        );
        await tester.pumpWidget(_makeTestableWidget());
        expect(finder, findsWidgets);
      });
    });
  });

  group("series tab widget test", () {
    group("check tab bar", () {
      setUp(() {
        final expected = WatchlistEmpty();
        when(bloc.state).thenReturn(expected);
        when(bloc.stream).thenAnswer((_) => Stream.value(expected));
      });

      testWidgets(
        "Should display tab bar",
        (widgetTester) async {
          await widgetTester.pumpWidget(_makeTestableWidget());
          expect(find.widgetWithText(Tab, 'TV Series'), findsOneWidget);
        },
      );

      testWidgets(
        "while tap on series tab bar should display Tabbar View",
        (widgetTester) async {
          await widgetTester.pumpWidget(_makeTestableWidget());
          final tab = find.widgetWithText(Tab, 'TV Series');
          await widgetTester.tap(tab);
          await widgetTester.pump();
          expect(find.byType(TabBarView), findsOneWidget);
        },
      );
    });

    group("when state is empty", () {
      setUp(() {
        final expected = WatchlistEmpty();
        when(bloc.state).thenReturn(expected);
        when(bloc.stream).thenAnswer((_) => Stream.value(expected));
      });
      testWidgets(
        "App bar widget test",
        (widgetTester) async {
          await widgetTester.pumpWidget(_makeTestableWidget());
          expect(find.text('Watchlist'), findsOneWidget);
        },
      );
      testWidgets('Page should display Container bar when state is empty',
          (WidgetTester tester) async {
        final centerFinder = find.byType(
          Container,
        );
        await tester.pumpWidget(_makeTestableWidget());
        expect(centerFinder, findsWidgets);
      });
    });

    group("when state is loading", () {
      setUp(() {
        final expected = WatchlistLoading();
        when(bloc.state).thenReturn(expected);
        when(bloc.stream).thenAnswer((_) => Stream.value(expected));
      });
      testWidgets('Page should display Container bar when state is empty',
          (WidgetTester tester) async {
        final progressFinder = find.byType(
          CircularProgressIndicator,
        );
        final centerFinder = find.byType(
          CircularProgressIndicator,
        );
        await tester.pumpWidget(_makeTestableWidget());
        expect(progressFinder, findsWidgets);
        expect(centerFinder, findsWidgets);
      });
    });

    group("when state is loaded", () {
      setUp(() {
        final expected = WatchlistLoaded(
          watchlistMovies: testMovieList,
          watchlistMoviesState: RequestState.loaded,
          watchlistSeries: testTvList,
          watchlistSeriesState: RequestState.loaded,
        );
        when(bloc.state).thenReturn(expected);
        when(bloc.stream).thenAnswer((_) => Stream.value(expected));
      });
      testWidgets('should display listview', (WidgetTester tester) async {
        final finder = find.byType(
          ListView,
        );
        await tester.pumpWidget(_makeTestableWidget());
        expect(finder, findsWidgets);
      });
    });

    group(" when state is error", () {
      setUp(() {
        final expected = WatchlistError('Error');
        when(bloc.state).thenReturn(expected);
        when(bloc.stream).thenAnswer((_) => Stream.value(expected));
      });
      testWidgets('should display text error', (WidgetTester tester) async {
        final finder = find.text(
          'Error',
        );
        await tester.pumpWidget(_makeTestableWidget());
        expect(finder, findsWidgets);
      });
    });
  });
}
