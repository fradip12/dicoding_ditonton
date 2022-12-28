import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecase/search_tv.dart';
import 'package:series/series.dart';

import '../../test_helpers.mocks.dart';



void main() {
  late SearchSeries usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = SearchSeries(mockTvRepository);
  });

  final tSeries = <TV>[];
  final tQuery = 'Bhagya';

  test('should get list of series from the repository', () async {
    when(mockTvRepository.searchSeries(tQuery))
        .thenAnswer((_) async => Right(tSeries));
    final result = await usecase.execute(tQuery);
    expect(result, Right(tSeries));
  });
}
