import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/presentation/pages/tv/tv_popular_page.dart';
import 'package:ditonton/presentation/provider/tv/tv_popular_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'tv_popular_page_test.mocks.dart';

@GenerateMocks([PopularTVNotifier])
void main() {
  late MockPopularTVNotifier mockPopularTVNotifier;
  setUp(() {
    mockPopularTVNotifier = MockPopularTVNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<PopularTVNotifier>.value(
      value: mockPopularTVNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockPopularTVNotifier.state).thenReturn(RequestState.Loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

   testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockPopularTVNotifier.state).thenReturn(RequestState.Loaded);
    when(mockPopularTVNotifier.movies).thenReturn(<TV>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockPopularTVNotifier.state).thenReturn(RequestState.Error);
    when(mockPopularTVNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

    expect(textFinder, findsOneWidget);
  });
}
