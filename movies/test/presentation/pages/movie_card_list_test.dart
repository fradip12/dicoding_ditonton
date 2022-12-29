import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  final movie = testMovie;
  Widget createWidgetUnderTest() {
    return MaterialApp(
      title: 'Flutter Tests',
      home: Scaffold(body: MovieCard(movie)),
    );
  }

  testWidgets(
    "Text title button is displayed",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.text(movie.title ?? '-'), findsOneWidget);
    },
  );
  testWidgets(
    "Text overview button is displayed",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.text(movie.overview ?? '-'), findsOneWidget);
    },
  );
}
