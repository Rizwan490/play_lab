
import 'dart:convert';

import 'package:get/get.dart';
import 'package:play_lab/data/model/all_episode/all_episodes_response_model.dart';
import 'package:play_lab/data/repo/all_episode_repo/all_episode_repo.dart';

import '../../model/global/response_model/response_model.dart';

class AllEpisodeController extends GetxController{

  AllEpisodeRepo repo;
  AllEpisodeController({required this.repo});

  String? nextPageUrl;
  bool isLoading=true;
  List<Data>episodeList=[];
  String portraitImagePath='';

  int page = 0;

  void fetchInitialMovieList() async {
    updateStatus(true);
    page =1; //page+1;
    ResponseModel model =
    await repo.getEpisode(page);

    if(model.statusCode==200)
    {

      AllEpisodeResponseModel allEpisodeResponse= AllEpisodeResponseModel.fromJson(jsonDecode(model.responseJson));
      List<Data>?tempEpisodeList=allEpisodeResponse.data?.episodes?.data;
      portraitImagePath=allEpisodeResponse.data?.portraitPath??'';
      nextPageUrl=allEpisodeResponse.data?.episodes?.nextPageUrl??'';

      if(tempEpisodeList !=null && tempEpisodeList.isNotEmpty)
      {
        episodeList.clear();
        episodeList.addAll(tempEpisodeList);
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
    await repo.getEpisode(page);

    if(model.statusCode==200)
    {

     AllEpisodeResponseModel allMovieResponseModel=AllEpisodeResponseModel.fromJson(jsonDecode(model.responseJson));
      List<Data>?tempMovieList=allMovieResponseModel.data?.episodes?.data;
      nextPageUrl=allMovieResponseModel.data?.episodes?.nextPageUrl;
      if(tempMovieList !=null && !(tempMovieList==[]) )
      {
        episodeList.addAll(tempMovieList);
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

  void clearAllData(){
    page=0;
    isLoading=true;
    nextPageUrl=null;
    episodeList.clear();
  }


  bool isGuest(){
    String token = repo.apiClient.token;
    if(token.isEmpty) {
      return true;
    }
    return false;
  }

}