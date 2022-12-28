import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/series.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvPopular usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvPopular(mockTvRepository);
  });

  final tTvSeries = <TV>[];

  test("should get list of tv from repository", () async {
    when(mockTvRepository.getPopularTv())
        .thenAnswer((realInvocation) async => Right(tTvSeries));
    final result = await usecase.execute();
    expect(result, Right(tTvSeries));
  });
}
