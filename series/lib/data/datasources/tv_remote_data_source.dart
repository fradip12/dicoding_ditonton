import 'dart:convert';
import 'package:common/common.dart';

import '../models/tv/tv_detail_model.dart';
import '../models/tv/tv_model.dart';
import '../models/tv/tv_response.dart';
import 'package:http/http.dart' as http;

abstract class TvRemoteDataSource {
  Future<List<TvModel>> getNowPlayingTv();
  Future<List<TvModel>> getPopularTv();
  Future<List<TvModel>> getTopRated();
  Future<TvDetailResponse> getTvDetail(int id);
  Future<List<TvModel>> getTvRecommendations(int id);
  Future<List<TvModel>> searchSeries(String query);
}

class TvRemoteDataSourceImpl implements TvRemoteDataSource {
  final http.Client client;
  TvRemoteDataSourceImpl(
    this.client,
  );

  @override
  Future<List<TvModel>> getNowPlayingTv() async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/airing_today?$apiKey'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getPopularTv() async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/popular?$apiKey'));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTopRated() async {
    final response =
        await client.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey'));
    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  // test this headers later
  Future<TvDetailResponse> getTvDetail(int id) async {
    final response = await client.get(
      Uri.parse('$baseUrl/tv/$id?$apiKey'),
      // headers: {
      //   HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
      // },
    );

    if (response.statusCode == 200) {
      return TvDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> getTvRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('$baseUrl/tv/$id/recommendations?$apiKey'));

    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvModel>> searchSeries(String query) async {
    final response = await client
        .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$query'));
    print(response.body);
    if (response.statusCode == 200) {
      return TvResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }
}
