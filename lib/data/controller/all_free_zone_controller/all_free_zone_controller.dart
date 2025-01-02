
import 'dart:convert';
import 'package:get/get.dart';
import 'package:play_lab/data/model/home/free_zone/free_zone_response_model.dart';
import '../../model/global/response_model/response_model.dart';
import '../../repo/free_zone_repo/free_zone_repo.dart';

class AllFreeZoneController extends GetxController{

  FreeZoneRepo repo;

  AllFreeZoneController({required this.repo});

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
    page =1; //page+1;
    ResponseModel model =
    await repo.getFreeZoneMovie(page);

    if(model.statusCode==200)
    {

      FreeZoneResponseModel freeZoneResponse= FreeZoneResponseModel.fromJson(jsonDecode(model.responseJson));
      List<Data>?tempMovieList=freeZoneResponse.data?.freeZone?.data;
      portraitImagePath=freeZoneResponse.data?.portraitPath??'';
      nextPageUrl=freeZoneResponse.data?.freeZone?.nextPageUrl??'';

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
    page =page+1; //page+1;
    ResponseModel model =
    await repo.getFreeZoneMovie(page);

    if(model.statusCode==200)
    {

     FreeZoneResponseModel allMovieResponseModel=FreeZoneResponseModel.fromJson(jsonDecode(model.responseJson));
      List<Data>?tempMovieList=allMovieResponseModel.data?.freeZone?.data;
      nextPageUrl=allMovieResponseModel.data?.freeZone?.nextPageUrl;
      if(tempMovieList !=null && !(tempMovieList==[]) )
      {
        movieList.addAll(tempMovieList);
      }
      update();
      updatePaginationLoading(false);
    }
  }

  updateStatus(bool status) {
    isLoading = status;
    update();
  }

  bool hasNext() {
    return nextPageUrl != null ? true : false;
  }

  void clearAllData(){
    page=0;
    isLoading=true;
    nextPageUrl=null;
    movieList.clear();
  }


}