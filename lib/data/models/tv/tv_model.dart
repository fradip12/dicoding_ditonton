import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:equatable/equatable.dart';

class TvModel extends Equatable {
  TvModel({
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

  final String? backdropPath;
  final String? firstAirDate;
  final List<int> genreIds;
  final int? id;
  final String? name;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? voteAverage;
  final int? voteCount;

  factory TvModel.fromJson(Map<String, dynamic> json) => TvModel(
        backdropPath: json["backdrop_path"],
        firstAirDate: json["first_air_date"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        name: json["name"],
        originCountry: json["origin_country"] != null ? List<String>.from(json["origin_country"].map((x) => x)) : [],
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        voteAverage: json["vote_average"].toString(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "first_air_date": firstAirDate,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "name": name,
        "origin_country": originCountry,
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "vote_average": int.parse(voteAverage!),
        "vote_count": voteCount,
      };

  TV toEntity() {
    return TV(
      backdropPath: this.backdropPath,
      genreIds: this.genreIds,
      id: this.id,
      overview: this.overview,
      popularity: this.popularity,
      posterPath: this.posterPath,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
      firstAirDate: this.firstAirDate,
      name: this.name,
      originCountry: this.originCountry,
      originalLanguage: this.originalLanguage,
      originalName: this.originalName,
    );
  }

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
