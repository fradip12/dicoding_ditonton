import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class TV extends Equatable {
  TV({
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
    this.firstAirDate,
    this.name,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
  });

  TV.watchlist({
    this.backdropPath,
    this.genreIds,
    required this.id,
    required this.overview,
    this.popularity,
    required this.posterPath,
    this.voteAverage,
    this.voteCount,
    this.firstAirDate,
    this.name,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
  });

  String? backdropPath;
  String? firstAirDate;
  List<int>? genreIds;
  int? id;
  String? name;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  String? voteAverage;
  int? voteCount;

  @override
  List<Object?> get props => [
        backdropPath,
        genreIds,
        id,
        overview,
        popularity,
        posterPath,
        voteAverage,
        voteCount,
        firstAirDate,
        name,
        originCountry,
        originalLanguage,
        originalName,
      ];
}
