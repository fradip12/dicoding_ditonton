import 'package:ditonton/data/models/tv/tv_detail_model.dart';
import 'package:ditonton/data/models/tv/tv_model.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final testSpokenModel =
      SpokenLanguageModel(englishName: 'id', iso6391: '1', name: 'indo');

  final testSpoken = Spoken(englishName: 'id', iso6391: '1', name: 'indo');
  final testSpokenMap = {
    "english_name": 'id',
    "iso_639_1": '1',
    "name": 'indo',
  };

  test('should be a subclass of Spoken entity', () async {
    final result = testSpokenModel.toEntity();
    expect(result, testSpoken);
  });

  test('should be a return Spokenlanguange model from map json', () async {
    final result = SpokenLanguageModel.fromJson(testSpokenMap);
    expect(result, testSpokenModel);
  });

  test('should be a Json', () async {
    final result = testSpokenModel.toJson();
    expect(result, testSpokenMap);
  });
}
