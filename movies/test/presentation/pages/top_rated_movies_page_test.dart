import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_objects.dart';
import 'home_movie_widget_test.mocks.dart';

@GenerateMocks([MovieListBloc])
void main() {
  late MockMovieListBloc bloc;

  setUp(() {
    bloc = MockMovieListBloc();
  });
  Widget _makeTestableWidget() {
    return BlocProvider<MovieListBloc>.value(
      value: bloc,
      child: MaterialApp(
        home: Scaffold(body: TopRatedMoviesPage()),
      ),
    );
  }

  group("toprated movies pages", () {
    testWidgets('Page should display Container bar when state is empty',
        (WidgetTester tester) async {
      final expected = MovieListEmpty();
      when(bloc.state).thenReturn(expected);
      when(bloc.stream).thenAnswer((_) => Stream.value(expected));
      final finder = find.byType(
        Container,
      );
      await tester.pumpWidget(_makeTestableWidget());
      expect(finder, findsWidgets);
    });
    testWidgets('Page should display center progress bar when loading',
        (WidgetTester tester) async {
      final expected = MovieListLoading();

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

    testWidgets(
        'RequestState == Loaded . Page should display List when state is loaded request state is loaded',
        (WidgetTester tester) async {
      final expected = MovieListLoaded(
        testMovieList,
        testMovieList,
        testMovieList,
        RequestState.Loaded,
        RequestState.Loaded,
        RequestState.Loaded,
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
        'RequestState == Error . Page should display List when state is loaded request state is loaded',
        (WidgetTester tester) async {
      final expected = MovieListLoaded(
        testMovieList,
        testMovieList,
        testMovieList,
        RequestState.Error,
        RequestState.Error,
        RequestState.Error,
      );

      when(bloc.state).thenReturn(expected);
      when(bloc.stream).thenAnswer((_) => Stream.value(expected));
      final centerFinder = find.text('Failed');
      await tester.pumpWidget(_makeTestableWidget());
      expect(centerFinder, findsWidgets);
    });

    testWidgets('Page should Text Failed Container bar when state is error',
        (WidgetTester tester) async {
      final expected = MovieListError('Failed');
      when(bloc.state).thenReturn(expected);
      when(bloc.stream).thenAnswer((_) => Stream.value(expected));
      final finder = find.text(
        'Failed',
      );
      await tester.pumpWidget(_makeTestableWidget());
      expect(finder, findsWidgets);
    });
  });
}
