import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_popular.dart';
import 'package:ditonton/presentation/provider/tv/tv_popular_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvPopular,
])
void main() {
  late MockGetTvPopular mockGetTvPopular;
  late PopularTVNotifier notifier;
  late int listenerCount;

  setUp(() {
    listenerCount = 0;
    mockGetTvPopular = MockGetTvPopular();
    notifier = PopularTVNotifier(mockGetTvPopular)
      ..addListener(() {
        listenerCount++;
      });
  });

  test('should change state to loading when usecase is called', () async {
    when(mockGetTvPopular.execute()).thenAnswer((_) async => Right(testTvList));
    notifier.fetchPopularTv();
    expect(notifier.state, RequestState.Loading);
    expect(listenerCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    when(mockGetTvPopular.execute()).thenAnswer((_) async => Right(testTvList));
    await notifier.fetchPopularTv();
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.movies, testTvList);
    expect(listenerCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    when(mockGetTvPopular.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    await notifier.fetchPopularTv();
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCount, 2);
  });
}
