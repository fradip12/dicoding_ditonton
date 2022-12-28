import 'package:common/common.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:series/series.dart';

@GenerateMocks([
  TvRemoteDataSource,
  TvLocalDataSource,
  TvRepository,
  DatabaseSeriesHelper,
  NetworkInfo,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
