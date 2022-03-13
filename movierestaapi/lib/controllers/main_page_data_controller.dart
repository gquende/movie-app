import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:movierestaapi/models/main_page_data.dart';
import 'package:movierestaapi/models/movie.dart';
import 'package:movierestaapi/services/movie_services.dart';

class MainPageDataController extends StateNotifier<MainPageData> {
  MainPageDataController([MainPageData state])
      : super(state ?? MainPageData.initial()) {
    getMovies();
  }

  final MovieService _movieService = GetIt.instance.get<MovieService>();

  Future<void> getMovies() async {
    try {
      List<Movie> _movies = [];
      _movies = await _movieService.getPopularMovies(page: state.page);
      state = state.copyWith(
          movies: [...state.movies, ..._movies], page: state.page + 1);
    } catch (e) {
      debugPrint(e);
    }
  }
}