import 'package:dartz/dartz.dart';
   
   
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:core/core.dart';
import '../../../dummy_data/dummy_objects.dart';
import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvTopRated,
])
void main() {
  late MockGetTvTopRated mockGetTvTopRated;
  late TopRatedTvNotifier notifier;
  late int listenerCount;

  setUp(() {
    listenerCount = 0;
    mockGetTvTopRated = MockGetTvTopRated();
    notifier = TopRatedTvNotifier(getTopRatedSeries: mockGetTvTopRated)
      ..addListener(() {
        listenerCount++;
      });
  });

  test('should change state to loading when usecase is called', () async {
    when(mockGetTvTopRated.execute())
        .thenAnswer((_) async => Right(testTvList));
    notifier.fetchTopRatedSeries();
    expect(notifier.state, RequestState.Loading);
    expect(listenerCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    when(mockGetTvTopRated.execute())
        .thenAnswer((_) async => Right(testTvList));
    await notifier.fetchTopRatedSeries();
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.movies, testTvList);
    expect(listenerCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    when(mockGetTvTopRated.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    await notifier.fetchTopRatedSeries();
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCount, 2);
  });
}
