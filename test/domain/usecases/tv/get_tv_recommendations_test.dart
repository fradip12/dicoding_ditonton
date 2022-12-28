import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/series.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvRecommendations usecase;
  late MockTvRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockTvRepository();
    usecase = GetTvRecommendations(mockMovieRepository);
  });

  final tId = 1;
  final tSeries = <TV>[];

  test('should get list of tv recommendations from the repository',
      () async {
    when(mockMovieRepository.getTvRecommendations(tId))
        .thenAnswer((_) async => Right(tSeries));
    final result = await usecase.execute(tId);
    expect(result, Right(tSeries));
  });
}
