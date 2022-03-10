import 'package:get_it/get_it.dart';
import 'package:movierestaapi/services/http_service.dart';

class MovieService {
  GetIt getIt = GetIt.instance;
  HTTPService _httpService;

  MovieService() {
    _httpService = getIt.get<HTTPService>();
  }
}