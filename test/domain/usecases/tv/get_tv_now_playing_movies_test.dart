import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_now_playing.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvNowPlayingMovies usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvNowPlayingMovies(mockTvRepository);
  });

  final tTvSeries = <TV>[];

  test("should get list of tv from repository", () async {
    when(mockTvRepository.getNowPlayingTv())
        .thenAnswer((realInvocation) async => Right(tTvSeries));
    final result = await usecase.execute();
    expect(result, Right(tTvSeries));
  });
}
