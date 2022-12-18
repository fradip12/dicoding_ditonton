import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:equatable/equatable.dart';


class TvDetailResponse extends Equatable {
  TvDetailResponse({
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
  final List<GenreModel>? genres;
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
  final List<SeasonModel>? seasons;
  final List<SpokenLanguageModel>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String? type;
  final double? voteAverage;
  final int? voteCount;

  factory TvDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvDetailResponse(
        adult: json["adult"] == null ? null : json["adult"],
        backdropPath:
            json["backdrop_path"] == null ? null : json["backdrop_path"],
        createdBy: json["created_by"] == null
            ? null
            : List<dynamic>.from(json["created_by"].map((x) => x)),
        episodeRunTime: json["episode_run_time"] == null
            ? null
            : List<int>.from(json["episode_run_time"].map((x) => x)),
        genres: json["genres"] == null
            ? null
            : List<GenreModel>.from(
                json["genres"].map((x) => GenreModel.fromJson(x))),
        id: json["id"] == null ? null : json["id"],
        inProduction:
            json["in_production"] == null ? null : json["in_production"],
        languages: json["languages"] == null
            ? null
            : List<String>.from(json["languages"].map((x) => x)),
        name: json["name"] == null ? null : json["name"],
        numberOfEpisodes: json["number_of_episodes"] == null
            ? null
            : json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"] == null
            ? null
            : json["number_of_seasons"],
        originCountry: json["origin_country"] == null
            ? null
            : List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"] == null
            ? null
            : json["original_language"],
        originalName:
            json["original_name"] == null ? null : json["original_name"],
        overview: json["overview"] == null ? null : json["overview"],
        popularity:
            json["popularity"] == null ? null : json["popularity"].toDouble(),
        posterPath: json["poster_path"] == null ? null : json["poster_path"],
        seasons: json["seasons"] == null
            ? null
            : List<SeasonModel>.from(
                json["seasons"].map((x) => SeasonModel.fromJson(x))),
        spokenLanguages: json["spoken_languages"] == null
            ? null
            : List<SpokenLanguageModel>.from(json["spoken_languages"]
                .map((x) => SpokenLanguageModel.fromJson(x))),
        status: json["status"] == null ? null : json["status"],
        tagline: json["tagline"] == null ? null : json["tagline"],
        type: json["type"] == null ? null : json["type"],
        voteAverage: json["vote_average"] == null ? null : json["vote_average"],
        voteCount: json["vote_count"] == null ? null : json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult == null ? null : adult,
        "backdrop_path": backdropPath == null ? null : backdropPath,
        "created_by": createdBy == null
            ? null
            : List<dynamic>.from(createdBy!.map((x) => x)),
        "episode_run_time": episodeRunTime == null
            ? null
            : List<dynamic>.from(episodeRunTime!.map((x) => x)),
        "genres": genres == null
            ? null
            : List<dynamic>.from(genres!.map((x) => x.toJson())),
        "id": id == null ? null : id,
        "in_production": inProduction == null ? null : inProduction,
        "languages": languages == null
            ? null
            : List<dynamic>.from(languages!.map((x) => x)),
        "name": name == null ? null : name,
        "number_of_episodes":
            numberOfEpisodes == null ? null : numberOfEpisodes,
        "number_of_seasons": numberOfSeasons == null ? null : numberOfSeasons,
        "origin_country": originCountry == null
            ? null
            : List<dynamic>.from(originCountry!.map((x) => x)),
        "original_language": originalLanguage == null ? null : originalLanguage,
        "original_name": originalName == null ? null : originalName,
        "overview": overview == null ? null : overview,
        "popularity": popularity == null ? null : popularity,
        "poster_path": posterPath == null ? null : posterPath,
        "seasons": seasons == null
            ? null
            : List<dynamic>.from(seasons!.map((x) => x.toJson())),
        "spoken_languages": spokenLanguages == null
            ? null
            : List<dynamic>.from(spokenLanguages!.map((x) => x.toJson())),
        "status": status == null ? null : status,
        "tagline": tagline == null ? null : tagline,
        "type": type == null ? null : type,
        "vote_average": voteAverage == null ? null : voteAverage,
        "vote_count": voteCount == null ? null : voteCount,
      };

  TvDetail toEntity() {
    return TvDetail(
      adult: this.adult,
      backdropPath: backdropPath,
      createdBy: this.createdBy,
      episodeRunTime: this.episodeRunTime,
      genres: genres?.map((e) => e.toEntity()).toList(),
      id: this.id,
      inProduction: this.inProduction,
      languages: this.languages,
      name: this.name,
      numberOfEpisodes: this.numberOfEpisodes,
      numberOfSeasons: this.numberOfSeasons,
      originCountry: this.originCountry,
      originalLanguage: this.originalLanguage,
      originalName: this.originalName,
      overview: this.overview,
      popularity: this.popularity,
      posterPath: this.posterPath,
      seasons: seasons?.map((e) => e.toEntity()).toList(),
      spokenLanguages: spokenLanguages?.map((e) => e.toEntity()).toList(),
      status: this.status,
      tagline: this.tagline,
      type: this.type,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }

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

class SeasonModel extends Equatable {
  SeasonModel({
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

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
        airDate:
            json["air_date"] == null ? null : DateTime.parse(json["air_date"]),
        episodeCount:
            json["episode_count"] == null ? null : json["episode_count"],
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        overview: json["overview"] == null ? null : json["overview"],
        posterPath: json["poster_path"],
        seasonNumber:
            json["season_number"] == null ? null : json["season_number"],
      );

  Map<String, dynamic> toJson() => {
        "air_date": airDate == null
            ? null
            : "${airDate?.year.toString().padLeft(4, '0')}-${airDate?.month.toString().padLeft(2, '0')}-${airDate?.day.toString().padLeft(2, '0')}",
        "episode_count": episodeCount == null ? null : episodeCount,
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "overview": overview == null ? null : overview,
        "poster_path": posterPath,
        "season_number": seasonNumber == null ? null : seasonNumber,
      };

  Season toEntity() {
    return Season(
      airDate: this.airDate,
      episodeCount: this.episodeCount,
      id: this.id,
      name: this.name,
      overview: this.overview,
      posterPath: this.posterPath,
      seasonNumber: this.seasonNumber,
    );
  }

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

class SpokenLanguageModel extends Equatable {
  SpokenLanguageModel({
    this.englishName,
    this.iso6391,
    this.name,
  });

  final String? englishName;
  final String? iso6391;
  final String? name;

  factory SpokenLanguageModel.fromJson(Map<String, dynamic> json) =>
      SpokenLanguageModel(
        englishName: json["english_name"] == null ? null : json["english_name"],
        iso6391: json["iso_639_1"] == null ? null : json["iso_639_1"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "english_name": englishName == null ? null : englishName,
        "iso_639_1": iso6391 == null ? null : iso6391,
        "name": name == null ? null : name,
      };

  Spoken toEntity() {
    return Spoken(
      englishName: this.englishName,
      iso6391: this.iso6391,
      name: this.name,
    );
  }

  @override
  List<Object?> get props => [
        englishName,
        iso6391,
        name,
      ];
}
