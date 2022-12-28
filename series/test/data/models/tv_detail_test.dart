
import 'package:flutter_test/flutter_test.dart';
import 'package:movies/movies.dart';
import 'package:series/series.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  final _testTvModel = TvDetailResponse(
      adult: false,
      backdropPath: 'backdropPath',
      genres: [GenreModel(id: 1, name: 'Action')],
      id: 1,
      originalLanguage: 'en',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      status: 'Status',
      tagline: 'Tagline',
      voteAverage: 1.1,
      voteCount: 1,
      createdBy: [],
      episodeRunTime: [],
      inProduction: true,
      languages: ['id'],
      name: 'name',
      numberOfEpisodes: 2,
      numberOfSeasons: 2,
      originCountry: ['id'],
      originalName: 'name',
      seasons: [],
      spokenLanguages: [],
      type: '');
  final _testTv = TvDetail(
      adult: false,
      backdropPath: 'backdropPath',
      genres: [Genre(id: 1, name: 'Action')],
      id: 1,
      originalLanguage: 'en',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      status: 'Status',
      tagline: 'Tagline',
      voteAverage: 1.1,
      voteCount: 1,
      createdBy: [],
      episodeRunTime: [],
      inProduction: true,
      languages: ['id'],
      name: 'name',
      numberOfEpisodes: 2,
      numberOfSeasons: 2,
      originCountry: ['id'],
      originalName: 'name',
      seasons: [],
      spokenLanguages: [],
      type: '');
  final _testTvMap = {
    'adult': false,
    'backdrop_path': 'backdropPath',
    'genres': [{'id': 1, 'name': 'Action'}],
    'id': 1,
    'original_language': 'en',
    'overview': 'overview',
    'popularity': 1,
    'poster_path': 'posterPath',
    'status': 'Status',
    'tagline': 'Tagline',
    'vote_average': 1.1,
    'vote_count': 1,
    'created_by': [],
    'episode_run_time': [],
    'in_production': true,
    'languages': ['id'],
    'name': 'name',
    'number_of_episodes': 2,
    'number_of_seasons': 2,
    'origin_country': ['id'],
    'original_name': 'name',
    'seasons': [],
    'spoken_languages': [],
    'type': ''
  };

  final testSpokenModel =
      SpokenLanguageModel(englishName: 'id', iso6391: '1', name: 'indo');

  final testSpoken = Spoken(englishName: 'id', iso6391: '1', name: 'indo');
  final testSpokenMap = {
    "english_name": 'id',
    "iso_639_1": '1',
    "name": 'indo',
  };

  final testSeasonModel = SeasonModel(
    airDate: DateTime.parse('2022-01-01T00:00:00.000'),
    episodeCount: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: '',
    seasonNumber: 1,
  );
  final testSeason = Season(
    airDate: DateTime.parse('2022-01-01T00:00:00.000'),
    episodeCount: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    posterPath: '',
    seasonNumber: 1,
  );

  final testSeasonMap = {
    'air_date': '2022-01-01T00:00:00.000',
    'episode_count': 1,
    'id': 1,
    'name': 'name',
    'overview': 'overview',
    'poster_path': '',
    'season_number': 1,
  };

  group("tv detail model", () {
    test('should return to Entity', () async {
      final result = _testTvModel.toEntity();
      expect(result, _testTv);
    });

    test('shoudl return from json', () async {
      final result = TvDetailResponse.fromJson(_testTvMap);
      expect(result, _testTvModel);
    });

    test('should return to Json', () async {
      final result = _testTvModel.toJson();
      expect(result, _testTvMap);
    });
  });

  group("spoken model", () {
    test('should return to Entity', () async {
      final result = testSpokenModel.toEntity();
      expect(result, testSpoken);
    });

    test('shoudl return from json', () async {
      final result = SpokenLanguageModel.fromJson(testSpokenMap);
      expect(result, testSpokenModel);
    });

    test('should return to Json', () async {
      final result = testSpokenModel.toJson();
      expect(result, testSpokenMap);
    });
  });

  group("season model", () {
    test('should return to Entity', () async {
      final result = testSeasonModel.toEntity();
      expect(result, testSeason);
    });

    test('shoudl return from json', () async {
      final result = SeasonModel.fromJson(testSeasonMap);
      expect(result, testSeasonModel);
    });

    test('should return to Json', () async {
      final result = testSeasonModel.toJson();
      expect(result, testSeasonMap);
    });
  });
}
