import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:series/presentation/widgets/tv_card_list.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  Widget _makeTestableWidget() {
    return MaterialApp(
      home: Scaffold(body: TvCard(testTv)),
    );
  }

  group("test all widget tv card", () {
    testWidgets(
      "should display widget with inkwell",
      (widgetTester) async {
        await widgetTester.pumpWidget(_makeTestableWidget());
        expect(find.byType(InkWell), findsOneWidget);
      },
    );
    testWidgets(
      "should display widget with stack",
      (widgetTester) async {
        await widgetTester.pumpWidget(_makeTestableWidget());
        expect(find.byType(Stack), findsWidgets);
      },
    );

    testWidgets(
      "card should display movie name, and overview",
      (widgetTester) async {
        await widgetTester.pumpWidget(_makeTestableWidget());
        expect(find.byType(Card), findsOneWidget);
        expect(find.text(testTv.name ?? '-'), findsOneWidget);
        expect(find.text(testTv.overview ?? '-'), findsOneWidget);
      },
    );
  });
}
