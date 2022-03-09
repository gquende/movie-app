import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movierestaapi/models/app_config.dart';

class HTTPService {
  final Dio dio = Dio();
  final GetIt getIt = GetIt.instance;

  String _base_url;
  String _api_key;

  HTTPService() {
    AppConfig _config = getIt.get<AppConfig>();
    _base_url = _config.BASE_API_URL;
    _api_key = _config.API_KEY;
  }

  Future<Response> get(String _path, {Map<String, dynamic> query}) async {
    try {
      String _url = "$_base_url$_path";
    } catch (e) {}
  }
}