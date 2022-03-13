import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movierestaapi/controllers/main_page_data_controller.dart';
import 'package:movierestaapi/models/main_page_data.dart';
import 'package:movierestaapi/models/movie.dart';
import 'package:movierestaapi/widgets/movie_tile.dart';

final mainPageDataControllerProvider =
    StateNotifierProvider<MainPageDataController>((ref) {
  return MainPageDataController();
});

class MainPage extends ConsumerWidget {
  double _deviceHeight;
  double _deviceWidth;
  List categories = ["Popular", "Upcoming"];
  String selectedCategory = "Popular";

  MainPageDataController _mainPageDataController;
  MainPageData _mainPageData;

  TextEditingController _searchTextEditingController;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _mainPageDataController = watch(mainPageDataControllerProvider);
    _mainPageData = watch(mainPageDataControllerProvider.state);

    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      /*Evite overflow na saida do teclado*/
      backgroundColor: Colors.black,
      body: Container(
        width: _deviceWidth,
        height: _deviceHeight,
        child: Stack(
          alignment: Alignment.center,
          children: [_backgroundWidget(), _foregroundWidget()],
        ),
      ),
    );
  }

  Widget _backgroundWidget() {
    return Container(
      width: _deviceWidth,
      height: _deviceHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
            image: NetworkImage(
                "https://google.com" /*TODO => Trocar esse endereco por uma que contem imagem*/),
            fit: BoxFit.cover),
      ),
      child: BackdropFilter(
        //Todo => Aprender sobre isso
        filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)),
        ),
      ),
    );
  }

  Widget _foregroundWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, _deviceHeight * 0.02, 0, 0),
      width: _deviceWidth * 0.88,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _topBarWidget(),
          Container(
            height: _deviceHeight * 0.83,
            padding: EdgeInsets.symmetric(vertical: _deviceHeight * 0.01),
            child: _movieListViewWidget(),
          )
        ],
      ),
    );
  }

  Widget _topBarWidget() {
    return Container(
      height: _deviceHeight * 0.08,
      decoration: BoxDecoration(
          color: Colors.black54, borderRadius: BorderRadius.circular(20.0)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [_searchFieldWidget(), _categorySelectionWidget()],
      ),
    );
  }

  Widget _searchFieldWidget() {
    final _border = InputBorder.none;
    return Container(
      width: _deviceWidth * 0.50,
      height: _deviceHeight * 0.05,
      child: TextField(
        controller: _searchTextEditingController,
        onSubmitted: (_input) {},
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            focusedBorder: _border,
            border: _border,
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white24,
            ),
            filled: false,
            fillColor: Colors.white24,
            hintStyle: TextStyle(color: Colors.white54),
            hintText: 'Search...'),
      ),
    );
  }

  Widget _categorySelectionWidget() {
    return DropdownButton(
      value: selectedCategory,
      dropdownColor: Colors.black38,
      icon: Icon(Icons.menu),
      underline: Container(
        color: Colors.white24,
        height: 1,
      ),
      items: categories
          .map<DropdownMenuItem>((e) => DropdownMenuItem(
                  child: Text(
                e,
                style: TextStyle(color: Colors.white),
              )))
          .toList(),
    );
  }

  Widget _movieListViewWidget() {
    final List<Movie> _movies = _mainPageData.movies;

    if (_movies.length != 0) {
      return ListView.builder(
          itemCount: moviesList.length,
          itemBuilder: (ctx, index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  vertical: _deviceHeight * 0.01, horizontal: 0),
              child: GestureDetector(
                onTap: () {},
                child: MovieTile(
                  movie: moviesList[index],
                  height: _deviceHeight * 0.20,
                  width: _deviceWidth * 0.85,
                ),
              ),
            );
          });
    } else {
      return Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      );
    }
  }
}