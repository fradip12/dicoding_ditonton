   
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'tv_nowplaying_page_test.mocks.dart';

@GenerateMocks([NowPlayingTvNotifier])
void main() {
  late MockNowPlayingTvNotifier mockNowNotifier;
  setUp(() {
    mockNowNotifier = MockNowPlayingTvNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<NowPlayingTvNotifier>.value(
      value: mockNowNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockNowNotifier.state).thenReturn(RequestState.Loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(NowPlayingTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNowNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNowNotifier.movies).thenReturn(<TV>[]);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(NowPlayingTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNowNotifier.state).thenReturn(RequestState.Error);
    when(mockNowNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(NowPlayingTvPage()));

    expect(textFinder, findsOneWidget);
  });
}
