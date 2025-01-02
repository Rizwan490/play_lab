
import 'dart:convert';
import 'package:get/get.dart';
import 'package:play_lab/data/model/all_movie/all_movies_response_model.dart';
import 'package:play_lab/data/repo/all_movies_repo/all_movies_repo.dart';
import '../../model/global/response_model/response_model.dart';

class AllMoviesController extends GetxController {

  AllMoviesRepo repo;
  AllMoviesController({required this.repo});

  String? nextPageUrl;
  bool isLoading=true;
  List<Data>movieList=[];
  String portraitImagePath='';

  bool paginationLoading=false;
  updatePaginationLoading(bool status){
    paginationLoading=status;
    update();
  }


  int page = 0;

  void fetchInitialMovieList() async {
    updateStatus(true);
    page =1;
    ResponseModel model =
    await repo.getMovie(page);

    if(model.statusCode==200)
    {

      AllMovieResponseModel allMovieResponseModel=AllMovieResponseModel.fromJson(jsonDecode(model.responseJson));
      List<Data>?tempMovieList=allMovieResponseModel.mainData?.movies?.data;
      portraitImagePath=allMovieResponseModel.mainData?.portraitPath??'';
      nextPageUrl=allMovieResponseModel.mainData?.movies?.nextPageUrl;

      if(tempMovieList !=null && !(tempMovieList==[]) )
      {
        movieList.clear();
        movieList.addAll(tempMovieList);
      }
      updateStatus(false);
    } else
    {
      updateStatus(false);
    }
  }

  void fetchNewMovieList() async {
    page = page + 1;
    ResponseModel model =
    await repo.getMovie(page);

    if(model.statusCode==200)
    {

      AllMovieResponseModel allMovieResponseModel=AllMovieResponseModel.fromJson(jsonDecode(model.responseJson));
      List<Data>?tempMovieList=allMovieResponseModel.mainData?.movies?.data;
      nextPageUrl=allMovieResponseModel.mainData?.movies?.nextPageUrl;
      if(tempMovieList !=null && !(tempMovieList==[]) )
      {
        movieList.addAll(tempMovieList);
      }
      update();
    }
  }

  updateStatus(bool status) {
    isLoading = status;
    update();
  }

  bool hasNext() {
    return nextPageUrl != null  && nextPageUrl!.isNotEmpty && nextPageUrl != 'null'? true : false;
  }

  void clearAllData(){
    page=0;
    isLoading=true;
    nextPageUrl=null;
    movieList.clear();
  }

  bool isGuest(){
    String token = repo.apiClient.token;
    if(token.isEmpty) {
      return true;
    }
    return false;
  }


}