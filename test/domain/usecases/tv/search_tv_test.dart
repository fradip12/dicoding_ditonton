import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';


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
