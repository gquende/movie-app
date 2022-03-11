import 'package:get_it/get_it.dart';
import 'package:movierestaapi/models/app_config.dart';

class Movie {
  final String name;
  final String language;
  final bool isAdult;
  final String description;
  final String posterPath;
  final String backdropPath;
  final num rating;
  final String releaseDate;

  Movie(
      {this.name,
      this.language,
      this.isAdult,
      this.description,
      this.posterPath,
      this.backdropPath,
      this.rating,
      this.releaseDate});

  factory Movie.fromJson(Map<String, dynamic> _json) {
    return Movie(
        name: _json['title'],
        language: _json['original_language'],
        isAdult: _json['adult'],
        description: _json['overview'],
        posterPath: _json['poster_path'],
        rating: _json['vote_average'],
        releaseDate: _json['realese_date']);
  }

  String posterUrl() {
    final AppConfig _appConfig = GetIt.instance.get<AppConfig>();
    return "${_appConfig.BASE_IMAGE_API_URL}${this.posterPath}";
  }
}

List<Movie> moviesList = [
  Movie(
      name: "Adolfo",
      language: "PT-PT",
      isAdult: false,
      description: "Oir",
      posterPath: "Eor",
      backdropPath: "EOR",
      rating: 23,
      releaseDate: "23-12-2012"),
  Movie(
      name: "Adolfo Fernando",
      language: "PT-PT",
      isAdult: false,
      description: "Oir",
      posterPath: "Eor",
      backdropPath: "EOR",
      rating: 23,
      releaseDate: "23-12-2012"),
  Movie(
      name: "Madalfo Quende",
      language: "PT-PT",
      isAdult: false,
      description: "Oir",
      posterPath: "Eor",
      backdropPath: "EOR",
      rating: 23,
      releaseDate: "23-12-2012")
];