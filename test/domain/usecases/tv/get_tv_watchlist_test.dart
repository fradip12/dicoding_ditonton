import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';


void main() {
  late GetTvWatchlistMovies usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvWatchlistMovies(mockTvRepository);
  });

  test('should get list of movies from the repository', () async {
    when(mockTvRepository.getWatchlistTv())
        .thenAnswer((_) async => Right(testTvList));
    final result = await usecase.execute();
    expect(result, Right(testTvList));
  });
}
