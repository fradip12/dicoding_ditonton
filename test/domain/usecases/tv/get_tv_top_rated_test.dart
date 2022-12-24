import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvTopRated usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvTopRated(mockTvRepository);
  });

  final tTvSeries = <TV>[];

  test("should get list of tv from repository", () async {
    when(mockTvRepository.getTopRated())
        .thenAnswer((realInvocation) async => Right(tTvSeries));
    final result = await usecase.execute();
    expect(result, Right(tTvSeries));
  });
}
