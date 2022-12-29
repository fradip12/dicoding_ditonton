import 'dart:io';

import 'package:about/about.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget createWidgetUnderTest() {
    return MaterialApp(
      title: 'Flutter Tests',
      home: Scaffold(body: AboutPage()),
    );
  }

  testWidgets(
    "Icon button is displayed",
    (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    },
  );

  testWidgets(
    "description is displayed",
    (widgetTester) async {
      await widgetTester.pumpWidget(createWidgetUnderTest());
      expect(find.text(aboutDesc), findsOneWidget);
    },
  );
}
