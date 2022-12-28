import 'package:flutter_test/flutter_test.dart';
import 'package:movies/features/movies/data/models/genre_model.dart';
import 'package:movies/features/movies/domain/entities/genre.dart';

void main() {
  final tGenreModel = GenreModel(
    id: 1,
    name: 'satu',
  );

  final tGenre = Genre(
    id: 1,
    name: 'satu',
  );
  final tGenreJson = {
    "id": 1,
    "name": 'satu',
  };

  test('should be a subclass of Genre entity', () async {
    final result = tGenreModel.toEntity();
    expect(result, tGenre);
  });

  test('Genre model should be a json', () async {
    final result = tGenreModel.toJson();
    expect(result, tGenreJson);
  });


}
