import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:core/core.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  TvRemoteDataSource,
  TvLocalDataSource,
  TvRepository,
  DatabaseHelper,
  NetworkInfo,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
