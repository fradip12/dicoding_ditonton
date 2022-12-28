import 'package:common/common.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:movies/movies.dart';
import 'package:series/series.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  TvRemoteDataSource,
  TvLocalDataSource,
  TvRepository,
  DatabaseMoviesHelper,
  DatabaseSeriesHelper,
  NetworkInfo,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
