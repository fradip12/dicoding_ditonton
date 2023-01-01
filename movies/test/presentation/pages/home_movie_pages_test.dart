import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_objects.dart';
import 'home_movie_widget_test.mocks.dart';

void main() {
  late MockMovieListBloc mockMovieListBloc;

  setUp(() {
    mockMovieListBloc = MockMovieListBloc();
  });
  Widget createWidgetUnderTest() {
    return BlocProvider<MovieListBloc>.value(
      value: mockMovieListBloc,
      child: MaterialApp(
        home: HomeMoviePage(),
      ),
    );
  }

  group("widget test", () {
    setUp(() {
      final expected = MovieListLoaded(
        testMovieList,
        testMovieList,
        testMovieList,
        RequestState.loaded,
        RequestState.loaded,
        RequestState.loaded,
      );
      when(mockMovieListBloc.state).thenReturn(expected);
      when(mockMovieListBloc.stream).thenAnswer((_) => Stream.value(expected));
    });
    testWidgets(
      "App bar widget test",
      (widgetTester) async {
        await widgetTester.pumpWidget(createWidgetUnderTest());
        expect(find.text('Ditonton'), findsOneWidget);
      },
    );
    testWidgets(
      "open drawer test",
      (widgetTester) async {
        await widgetTester.pumpWidget(createWidgetUnderTest());
        final ScaffoldState state =
            widgetTester.firstState(find.byType(Scaffold));
        state.openDrawer();
        expect(state.hasDrawer, true);
      },
    );
    testWidgets(
      "drawer should display list tile movies",
      (widgetTester) async {
        await widgetTester.pumpWidget(createWidgetUnderTest());
        final ScaffoldState state =
            widgetTester.firstState(find.byType(Scaffold));
        state.openDrawer();
        await widgetTester.pump();
        expect(find.byIcon(Icons.movie), findsWidgets);
        expect(find.text('Movies'), findsWidgets);
      },
    );

    testWidgets(
      "drawer should display list tile about",
      (widgetTester) async {
        await widgetTester.pumpWidget(createWidgetUnderTest());
        final ScaffoldState state =
            widgetTester.firstState(find.byType(Scaffold));
        state.openDrawer();
        await widgetTester.pump();
        expect(find.byIcon(Icons.save_alt), findsWidgets);
        expect(find.text('About'), findsWidgets);
      },
    );

    testWidgets(
      "drawer tap listtile movies should display home movie",
      (widgetTester) async {
        await widgetTester.pumpWidget(createWidgetUnderTest());
        final ScaffoldState state =
            widgetTester.firstState(find.byType(Scaffold));
        state.openDrawer();
        await widgetTester.pump();
        await widgetTester.tap(
          find.widgetWithText(ListTile, 'Movies'),
          warnIfMissed: false,
        );
        expect(find.byType(HomeMovie), findsOneWidget);
      },
    );

    // testWidgets(
    //   "drawer tap listtile tv series should display home tv",
    //   (widgetTester) async {
    //     await widgetTester.pumpWidget(createWidgetUnderTest());
    //     final ScaffoldState state =
    //         widgetTester.firstState(find.byType(Scaffold));
    //     state.openDrawer();
    //     await widgetTester.pump();
    //     await widgetTester.tap(find.widgetWithText(ListTile, 'TV Series'));
    //     await widgetTester.pump();
    //     expect(find.byType(HomeTv), findsOneWidget);
    //   },
    // );
  });
}
