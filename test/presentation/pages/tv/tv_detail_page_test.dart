   
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_detail_page_test.mocks.dart';

@GenerateMocks([TvDetailNotifier])
void main() {
  late MockTvDetailNotifier mockTvDetailNotifier;

  setUp(() {
    mockTvDetailNotifier = MockTvDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvDetailNotifier>.value(
      value: mockTvDetailNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(mockTvDetailNotifier.movieState).thenReturn(RequestState.Loaded);
    when(mockTvDetailNotifier.movie).thenReturn(testTvDetail);
    when(mockTvDetailNotifier.recommendationState)
        .thenReturn(RequestState.Loaded);
    when(mockTvDetailNotifier.tvRecommendations).thenReturn(<TV>[]);
    when(mockTvDetailNotifier.isAddedToWatchlist).thenReturn(false);

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });
  testWidgets(
      'Watchlist button should display check icon when movie added to watchlist',
      (WidgetTester tester) async {
    when(mockTvDetailNotifier.movieState).thenReturn(RequestState.Loaded);
    when(mockTvDetailNotifier.movie).thenReturn(testTvDetail);
    when(mockTvDetailNotifier.recommendationState)
        .thenReturn(RequestState.Loaded);
    when(mockTvDetailNotifier.tvRecommendations).thenReturn(<TV>[]);
    when(mockTvDetailNotifier.isAddedToWatchlist).thenReturn(true);

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(mockTvDetailNotifier.movieState).thenReturn(RequestState.Loaded);
    when(mockTvDetailNotifier.movie).thenReturn(testTvDetail);
    when(mockTvDetailNotifier.recommendationState)
        .thenReturn(RequestState.Loaded);
    when(mockTvDetailNotifier.tvRecommendations).thenReturn(<TV>[]);
    when(mockTvDetailNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockTvDetailNotifier.watchlistMessage)
        .thenReturn('Added to Watchlist');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(mockTvDetailNotifier.movieState).thenReturn(RequestState.Loaded);
    when(mockTvDetailNotifier.movie).thenReturn(testTvDetail);
    when(mockTvDetailNotifier.recommendationState)
        .thenReturn(RequestState.Loaded);
    when(mockTvDetailNotifier.tvRecommendations).thenReturn(<TV>[]);
    when(mockTvDetailNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockTvDetailNotifier.watchlistMessage).thenReturn('Failed');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
