import 'dart:convert';
import 'dart:io';
   
import 'package:common/common.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:series/series.dart';
import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  late TvRemoteDataSourceImpl source;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    source = TvRemoteDataSourceImpl(mockHttpClient);
  });

  group("get now playing tv series", () {
    final tMovieList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/tv_now_playing.json')))
        .movieList;

    test("Should return list of tv series model when the response is 200",
        () async {
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/airing_today?$apiKey')))
          .thenAnswer((realInvocation) async =>
              http.Response(readJson('dummy_data/tv_now_playing.json'), 200));
      final result = await source.getNowPlayingTv();
      expect(result, equals(tMovieList));
    });
  });
  group("get popular tv series", () {
    final tMovieList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/tv_now_playing.json')))
        .movieList;

    test("Should return list of tv series model when the response is 200",
        () async {
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer((realInvocation) async =>
              http.Response(readJson('dummy_data/tv_now_playing.json'), 200));
      final result = await source.getPopularTv();
      expect(result, equals(tMovieList));
    });
  });

  group("get top rated tv series", () {
    final tMovieList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/tv_now_playing.json')))
        .movieList;

    test("Should return list of tv series model when the response is 200",
        () async {
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer((realInvocation) async =>
              http.Response(readJson('dummy_data/tv_now_playing.json'), 200));
      final result = await source.getTopRated();
      expect(result, equals(tMovieList));
    });
  });

  group('get tv detail', () {
    final tId = 1;
    final tTvDetail = TvDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv_detail.json')));

    test('should return tv detail when the response code is 200', () async {
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')))
          .thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/tv_detail.json'),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );
      final result = await source.getTvDetail(tId);
      expect(result, equals(tTvDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      final call = source.getTvDetail(tId);
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv recommendations', () {
    final tTvList = TvResponse.fromJson(
            json.decode(readJson('dummy_data/tv_recommendations.json')))
        .movieList;
    final tId = 1;

    test('should return list of Movie Model when the response code is 200',
        () async {
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey')))
          .thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/tv_recommendations.json'),
          200,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          },
        ),
      );
      final result = await source.getTvRecommendations(tId);
      expect(result, equals(tTvList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      final call = source.getTvRecommendations(tId);
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search movies', () {
    final tSearchResult = TvResponse.fromJson(
            json.decode(readJson('dummy_data/search_tv_movie.json')))
        .movieList;
    final tQuery = 'Bhagya';

    test('should return list of movies when response code is 200', () async {
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQuery')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/search_tv_movie.json'), 200));
      final result = await source.searchSeries(tQuery);
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      final call = source.searchSeries(tQuery);
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
