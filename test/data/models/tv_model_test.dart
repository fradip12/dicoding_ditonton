import 'package:ditonton/data/models/movie_model.dart';
import 'package:ditonton/data/models/tv/tv_model.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvmodel = TvModel(
    name: 'name',
    firstAirDate: '01-01-2022',
    originCountry: ['ID'],
    originalLanguage: 'ID',
    originalName: 'name',
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: '1',
    voteCount: 1,
  );

  final tTv = TV(
    name: 'name',
    firstAirDate: '01-01-2022',
    originCountry: ['ID'],
    originalLanguage: 'ID',
    originalName: 'name',
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: '1',
    voteCount: 1,
  );

  test('should be a subclass of Movie entity', () async {
    final result = tTvmodel.toEntity();
    expect(result, tTv);
  });
}
