import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movierestaapi/models/movie.dart';
import 'package:movierestaapi/services/http_service.dart';

class MovieService {
  GetIt getIt = GetIt.instance;
  HTTPService _httpService;

  MovieService() {
    _httpService = getIt.get<HTTPService>();
  }

  Future<List<Movie>> getPopularMovies({int page}) async {
    Response _response =
        await _httpService.get("/movie/popular", query: {'page': page});

    if (_response.statusCode == 200) {
      Map _data = _response.data;
      List<Movie> _movies = _data['results'].map<Movie>((_movieData) {
        return Movie.fromJson(_movieData);
      }).toList();
      return _movies;
    } else {
      throw Exception(' Could not load Kist movies');
    }
  }
}