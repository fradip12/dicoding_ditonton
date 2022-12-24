import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SaveTvWatchlist usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = SaveTvWatchlist(mockTvRepository);
  });

  test('should save movie to the repository', () async {
    when(mockTvRepository.saveTvWatchlist(testTvDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    final result = await usecase.execute(testTvDetail);
    verify(mockTvRepository.saveTvWatchlist(testTvDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
