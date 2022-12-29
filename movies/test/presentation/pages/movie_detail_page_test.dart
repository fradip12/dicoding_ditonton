import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_page_test.mocks.dart';

@GenerateMocks([MovieDetailBloc])
void main() {
  late MockMovieDetailBloc bloc;

  setUp(() {
    bloc = MockMovieDetailBloc();
  });

  Widget _makeTestableWidget() {
    return BlocProvider<MovieDetailBloc>.value(
      value: bloc,
      child: MaterialApp(
        home: Scaffold(
            body: MovieDetailPage(
          id: 1,
        )),
      ),
    );
  }

  group("detail movies", () {
    testWidgets('Page should display Container when state is empty',
        (WidgetTester tester) async {
      final expected = MovieDetailEmpty();
      when(bloc.state).thenReturn(expected);
      when(bloc.stream).thenAnswer((_) => Stream.value(expected));
      final containerFinder = find.byType(Container, skipOffstage: false);

      await tester.pumpWidget(_makeTestableWidget());
      expect(
        containerFinder,
        findsOneWidget,
      );
    });

    testWidgets('Page should display circular progress when state is loading',
        (WidgetTester tester) async {
      final expected = MovieDetailLoading();
      when(bloc.state).thenReturn(expected);
      when(bloc.stream).thenAnswer((_) => Stream.value(expected));
      final progressFinder =
          find.byType(CircularProgressIndicator, skipOffstage: false);
      final centerFinder = find.byType(Center, skipOffstage: false);
      await tester.pumpWidget(_makeTestableWidget());
      expect(
        centerFinder,
        findsOneWidget,
      );
      expect(
        progressFinder,
        findsOneWidget,
      );
    });

    testWidgets('Page should Content when state is loaded',
        (WidgetTester tester) async {
      final expected = MovieDetailLoaded(
        testMovieDetail,
        testMovieList,
        false,
      );
      when(bloc.state).thenReturn(expected);
      when(bloc.stream).thenAnswer((_) => Stream.value(expected));
      final contentFinder = find.byType(DetailContent);
      await tester.pumpWidget(_makeTestableWidget());
      expect(
        contentFinder,
        findsOneWidget,
      );
    });

    testWidgets('Page should display progress when watchlist added/remove',
        (WidgetTester tester) async {
      final expected = WatchlistDialog('Added/Remove to watchlist');
      when(bloc.state).thenReturn(expected);
      when(bloc.stream).thenAnswer((_) => Stream.value(expected));
      final finder =
          find.byType(CircularProgressIndicator, skipOffstage: false);

      await tester.pumpWidget(_makeTestableWidget());
      expect(
        finder,
        findsOneWidget,
      );
    });
    testWidgets('Page should display Text Failed when state error',
        (WidgetTester tester) async {
      final expected = MovieDetailError('Failed');
      when(bloc.state).thenReturn(expected);
      when(bloc.stream).thenAnswer((_) => Stream.value(expected));
      final finder = find.text('Failed');

      await tester.pumpWidget(_makeTestableWidget());
      expect(
        finder,
        findsOneWidget,
      );
    });
  });
}
