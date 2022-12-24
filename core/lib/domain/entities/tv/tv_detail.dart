import 'package:equatable/equatable.dart';

import '../genre.dart';

class TvDetail extends Equatable {
  TvDetail({
    this.adult,
    this.backdropPath,
    this.createdBy,
    this.episodeRunTime,
    this.genres,
    this.id,
    this.inProduction,
    this.languages,
    this.name,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.seasons,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.type,
    this.voteAverage,
    this.voteCount,
  });

  final bool? adult;
  final String? backdropPath;
  final List<dynamic>? createdBy;
  final List<int>? episodeRunTime;
  final List<Genre>? genres;
  final int? id;
  final bool? inProduction;
  final List<String>? languages;
  final String? name;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final List<String?>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final List<Season>? seasons;
  final List<Spoken>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String? type;
  final double? voteAverage;
  final int? voteCount;

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        createdBy,
        episodeRunTime,
        genres,
        id,
        inProduction,
        languages,
        name,
        numberOfEpisodes,
        numberOfSeasons,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        seasons,
        spokenLanguages,
        status,
        tagline,
        type,
        voteAverage,
        voteCount,
      ];
}

class Season extends Equatable {
  Season({
    this.airDate,
    this.episodeCount,
    this.id,
    this.name,
    this.overview,
    this.posterPath,
    this.seasonNumber,
  });

  final DateTime? airDate;
  final int? episodeCount;
  final int? id;
  final String? name;
  final String? overview;
  final dynamic posterPath;
  final int? seasonNumber;

  @override
  List<Object?> get props => [
        airDate,
        episodeCount,
        id,
        name,
        overview,
        posterPath,
        seasonNumber,
      ];
}

class Spoken extends Equatable {
  Spoken({
    this.englishName,
    this.iso6391,
    this.name,
  });

  final String? englishName;
  final String? iso6391;
  final String? name;

  @override
  List<Object?> get props => [
        englishName,
        iso6391,
        name,
      ];
}
