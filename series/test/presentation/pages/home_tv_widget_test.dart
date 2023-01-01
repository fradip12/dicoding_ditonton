import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/presentation/bloc/tv/tv_list_bloc/tv_list_bloc.dart';
import 'package:series/presentation/pages/home_tv_widget.dart';

import '../../dummy_data/dummy_objects.dart';
import 'home_tv_widget_test.mocks.dart';

@GenerateMocks([TvListBloc])
void main() { 
  late MockTvListBloc bloc;

  setUp(() {
    bloc = MockTvListBloc();
  });

  Widget _makeTestableWidget() {
    return BlocProvider<TvListBloc>.value(
      value: bloc,
      child: MaterialApp(
        home: Scaffold(body: HomeTv()),
      ),
    );
  }

  group('widget test', () {
    testWidgets('Page should display center progress bar when loading',
        (WidgetTester tester) async {
      final expected = TvListLoading();

      when(bloc.state).thenReturn(expected);
      when(bloc.stream).thenAnswer((_) => Stream.value(expected));

      final progressBarFinder =
          find.byType(CircularProgressIndicator, skipOffstage: false);
      final centerFinder = find.byType(Center, skipOffstage: false);

      await tester.pumpWidget(_makeTestableWidget());

      expect(centerFinder, findsWidgets);
      expect(
        progressBarFinder,
        findsWidgets,
      );
    });

    testWidgets('Page should display Container bar when state is empty',
        (WidgetTester tester) async {
      final expected = TvListInitial();
      when(bloc.state).thenReturn(expected);
      when(bloc.stream).thenAnswer((_) => Stream.value(expected));
      final centerFinder = find.byType(
        Container,
      );
      await tester.pumpWidget(_makeTestableWidget());
      expect(centerFinder, findsWidgets);
    });

    testWidgets(
        'Page should display List when state is loaded request state is loaded',
        (WidgetTester tester) async {
      final expected = TvListLoaded(
        testTvList,
        testTvList,
        testTvList,
        RequestState.loaded,
        RequestState.loaded,
        RequestState.loaded,
      );

      when(bloc.state).thenReturn(expected);
      when(bloc.stream).thenAnswer((_) => Stream.value(expected));
      final centerFinder = find.byType(
        ListView,
      );
      await tester.pumpWidget(_makeTestableWidget());
      expect(centerFinder, findsWidgets);
    });

    testWidgets(
        'Page should display Text Failed when state is and loaded request state is error',
        (WidgetTester tester) async {
      final expected = TvListLoaded(
        testTvList,
        testTvList,
        testTvList,
        RequestState.error,
        RequestState.error,
        RequestState.error,
      );

      when(bloc.state).thenReturn(expected);
      when(bloc.stream).thenAnswer((_) => Stream.value(expected));
      final centerFinder = find.text(
        'Failed',
      );
      await tester.pumpWidget(_makeTestableWidget());
      expect(centerFinder, findsWidgets);
    });
  });
}
