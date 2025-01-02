import 'dart:convert';
import 'package:get/get.dart';
import 'package:play_lab/data/model/search/my_search_response_model.dart';
import 'package:play_lab/data/repo/my_search/my_search_repo.dart';
import '../../model/global/response_model/response_model.dart';

class MySearchController extends GetxController {
  MySearchRepo repo;
  MySearchController({required this.repo, this.searchText = '', this.subCategoryId = -1, this.categoryId = -1});

  String? nextPageUrl;
  bool isLoading = true;
  List<Data> movieList = [];
  int categoryId = -1;
  int subCategoryId = -1;
  int subCategoryIndex = -1;
  late String searchText;
  String portraitImagePath = '';

  changeSelectedSubCategoryIndex(int index) {
    subCategoryIndex = index;
    update();
  }

  void changeSubCategoryId(int id) {
    if (id != subCategoryId) {
      subCategoryId = id;
      fetchInitialSubCategoryData();
      update();
    }
  }

  int page = 0;

  void fetchInitialSubCategoryData() async {
    page = 1; //page+1;
    movieList.clear();
    updateStatus(true);

    ResponseModel model = await repo.getMovie(page: page, searchText: searchText, categoryId: categoryId, subCategoryId: subCategoryId);

    if (model.statusCode == 200) {
      MySearchResponseModel searchResponse = MySearchResponseModel.fromJson(jsonDecode(model.responseJson));
      List<Data>? teamMovieList = searchResponse.data?.items?.data;
      nextPageUrl = searchResponse.data?.items?.nextPageUrl;

      if (teamMovieList != null && teamMovieList.isNotEmpty) {
        if (page == 1) movieList.clear();
        movieList.addAll(teamMovieList);
      }
    }
    updateStatus(false);
  }

  void fetchSubCategoryData() async {
    page = page + 1; //page+1;
    ResponseModel model = await repo.getMovie(page: page, searchText: searchText, categoryId: categoryId, subCategoryId: subCategoryId);

    if (model.statusCode == 200) {
      MySearchResponseModel searchResponse = MySearchResponseModel.fromJson(jsonDecode(model.responseJson));
      List<Data>? teamMovieList = searchResponse.data?.items?.data;
      nextPageUrl = searchResponse.data?.items?.nextPageUrl;

      if (teamMovieList != null && teamMovieList.isNotEmpty) {
        movieList.addAll(teamMovieList);
      }
      update();
    }
  }

  updateStatus(bool status) {
    isLoading = status;
    update();
  }

  bool hasNext() {
    return nextPageUrl != null && nextPageUrl!.isNotEmpty && nextPageUrl != 'null' ? true : false;
  }

  void clearAllData() {
    page = 0;
    isLoading = true;
    nextPageUrl = null;
    subCategoryId = -1;
    categoryId = -1;
    movieList.clear();
  }

  bool isGuest() {
    String token = repo.apiClient.token;
    if (token.isEmpty) {
      return true;
    }
    return false;
  }
}
