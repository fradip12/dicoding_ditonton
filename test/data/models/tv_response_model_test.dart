import 'dart:convert';

import 'package:ditonton/data/models/tv/tv_model.dart';
import 'package:ditonton/data/models/tv/tv_response.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvmodel = TvModel(
    name: 'Bhagya Lakshmi',
    firstAirDate: '2021-08-03',
    originCountry: ["IN"],
    originalLanguage: 'en',
    originalName: 'Bhagya Lakshmi',
    backdropPath: "/AvYjbjY63kh8FgYlpgLJRGHc6H4.jpg",
    genreIds: [10766],
    id: 130542,
    overview:
        'Hailing from a middle-class family, Lakshmis life is upended when she realises that her marriage to Rishi Oberoi, an industrialists son, is a sham to keep his death at bay.',
    popularity: 1543.381,
    posterPath: '/7XEE8LyVxEJl5l4IK9r1wytDBPm.jpg',
    voteAverage: '1',
    voteCount: 1,
  );

  final tTvResponseModel = TvResponse(movieList: <TvModel>[tTvmodel]);

  group("fromJson", () {
    test("should return a valid model from Json", () async {
      final Map<String, dynamic> map =
          json.decode(readJson('dummy_data/tv_now_playing.json'));
      final result = TvResponse.fromJson(map);
      expect(result, tTvResponseModel);
    });
  });

  group("toJson", () {
    test("should return a JSON", () async {
      final result = tTvResponseModel.toJson();
      final expectedMap = {
        "results": [
          {
            "backdrop_path": "/AvYjbjY63kh8FgYlpgLJRGHc6H4.jpg",
            "first_air_date": "2021-08-03",
            "genre_ids": [10766],
            "id": 130542,
            "name": "Bhagya Lakshmi",
            "origin_country": ["IN"],
            "original_language": "en",
            "original_name": "Bhagya Lakshmi",
            "overview":
                "Hailing from a middle-class family, Lakshmis life is upended when she realises that her marriage to Rishi Oberoi, an industrialists son, is a sham to keep his death at bay.",
            "popularity": 1543.381,
            "poster_path": "/7XEE8LyVxEJl5l4IK9r1wytDBPm.jpg",
            "vote_average": 1,
            "vote_count": 1
          }
        ],
      };
      expect(result, expectedMap);
    });
  });
}
