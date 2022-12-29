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
  late MockMovieListBloc mockMovieListBloc;

  setUp(() {
    mockMovieListBloc = MockMovieListBloc();
  });

  Widget _makeTestableWidget() {
    return BlocProvider<MovieListBloc>.value(
      value: mockMovieListBloc,
      child: MaterialApp(
        home: Scaffold(body: HomeMovie()),
      ),
    );
  }

  group('widget test', () {
    testWidgets('Page should display center progress bar when loading',
        (WidgetTester tester) async {
      final expected = MovieListLoading();

      when(mockMovieListBloc.state).thenReturn(expected);
      when(mockMovieListBloc.stream).thenAnswer((_) => Stream.value(expected));

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
      final expected = MovieListEmpty();
      when(mockMovieListBloc.state).thenReturn(expected);
      when(mockMovieListBloc.stream).thenAnswer((_) => Stream.value(expected));
      final centerFinder = find.byType(
        Container,
      );
      await tester.pumpWidget(_makeTestableWidget());
      expect(centerFinder, findsWidgets);
    });

    testWidgets(
        'Page should display List when state is loaded request state is loaded',
        (WidgetTester tester) async {
      final expected = MovieListLoaded(
        testMovieList,
        testMovieList,
        testMovieList,
        RequestState.Loaded,
        RequestState.Loaded,
        RequestState.Loaded,
      );

      when(mockMovieListBloc.state).thenReturn(expected);
      when(mockMovieListBloc.stream).thenAnswer((_) => Stream.value(expected));
      final centerFinder = find.byType(
        ListView,
      );
      await tester.pumpWidget(_makeTestableWidget());
      expect(centerFinder, findsWidgets);
    });

    testWidgets(
        'Page should display Text Failed when state is and loaded request state is error',
        (WidgetTester tester) async {
      final expected = MovieListLoaded(
        testMovieList,
        testMovieList,
        testMovieList,
        RequestState.Error,
        RequestState.Error,
        RequestState.Error,
      );

      when(mockMovieListBloc.state).thenReturn(expected);
      when(mockMovieListBloc.stream).thenAnswer((_) => Stream.value(expected));
      final centerFinder = find.text(
        'Failed',
      );
      await tester.pumpWidget(_makeTestableWidget());
      expect(centerFinder, findsWidgets);
    });
  });
}
