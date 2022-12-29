import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/series.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_page_test.mocks.dart';

@GenerateMocks([TvDetailBloc])
void main() {
  late MockTvDetailBloc bloc;

  setUp(() {
    bloc = MockTvDetailBloc();
  });

  Widget _makeTestableWidget() {
    return BlocProvider<TvDetailBloc>.value(
      value: bloc,
      child: MaterialApp(
        home: Scaffold(
          body: TvDetailPage(
            id: 1,
          ),
        ),
      ),
    );
  }

  group("detail tv", () {
    testWidgets('Page should display Container when state is empty',
        (WidgetTester tester) async {
      final expected = TvDetailEmpty();
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
      final expected = TvDetailLoading();
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

    testWidgets('Page should display Content when state is loaded',
        (WidgetTester tester) async {
      final expected = TvDetailLoaded(
        testTvDetail,
        testTvList,
        false,
      );
      when(bloc.state).thenReturn(expected);
      when(bloc.stream).thenAnswer((_) => Stream.value(expected));
      final contentFinder = find.byType(DetailTvContent);
      await tester.pumpWidget(_makeTestableWidget());
      expect(
        contentFinder,
        findsOneWidget,
      );
    });

    testWidgets('Page should display progress when watchlist added/remove',
        (WidgetTester tester) async {
      final expected = WatchlistTvDialog('Added/Remove to watchlist');
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
      final expected = TvDetailError('Failed');
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
