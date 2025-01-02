
import 'dart:convert';
import 'package:get/get.dart';
import 'package:play_lab/data/model/wishlist_model/add_in_wishlist_response_model.dart';
import 'package:play_lab/data/model/wishlist_model/wish_list_response_model.dart';
import 'package:play_lab/data/repo/wish_list_repo/wish_list_repo.dart';
import 'package:play_lab/view/components/show_custom_snackbar.dart';
import '../../model/global/response_model/response_model.dart';

class WishListController extends GetxController {

  WishListRepo repo;
  WishListController({required this.repo});


  String? nextPageUrl;
  bool isLoading=true;
  List<Data>wishlist=[];
  String portraitImagePath='';



  int page = 0;

  void fetchInitialWishlist() async {
    updateStatus(true);
    page =1; //page+1;
    ResponseModel model =
    await repo.getWishList(page);

    if(model.statusCode==200)
    {

      WishlistResponseModel responseModel = WishlistResponseModel.fromJson(jsonDecode(model.responseJson));
      List<Data>?tempWishList=responseModel.data?.wishlists?.data;
      portraitImagePath = 'assets/images/item/portrait/' ;
      nextPageUrl = responseModel.data?.wishlists?.nextPageUrl;

      if(tempWishList !=null && tempWishList.isNotEmpty)
      {
        if(page==1) wishlist.clear();
        wishlist.addAll(tempWishList);
      }
    }
      updateStatus(false);
  }

  void fetchNewWishlist() async {
    page =page+1;
    ResponseModel model =
    await repo.getWishList(page);

    if(model.statusCode==200)
    {

      WishlistResponseModel responseModel=WishlistResponseModel.fromJson(jsonDecode(model.responseJson));
      List<Data>?tempWishList=responseModel.data?.wishlists?.data;
      portraitImagePath='assets/images/item/portrait/';
      nextPageUrl=responseModel.data?.wishlists?.nextPageUrl;

      if(tempWishList !=null && tempWishList.isNotEmpty) {
        wishlist.addAll(tempWishList);
      }
      update();
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
    wishlist.clear();
  }

  bool removeLoading=false;
  int selectedIndex=-1;
  void removeFromWishlist(int index)async{
    removeLoading=true;
    selectedIndex=index;
    update();
     ResponseModel model=await repo.removeFromWishlist(int.tryParse(wishlist[index].itemId??'0')??0,int.tryParse(wishlist[index].episodeId??'0')??0);

     if(model.statusCode==200){
       AddInWishlistResponseModel responseModel=AddInWishlistResponseModel.fromJson(jsonDecode(model.responseJson));
       if(responseModel.status=='success'){
         wishlist.removeAt(index);
         CustomSnackbar.showCustomSnackbar(errorList: [], msg: [responseModel.message?.success??'Successfully removed'], isError: false);
         removeLoading=false;
         update();
       }else{
         CustomSnackbar.showCustomSnackbar(errorList: [responseModel.message?.error??'Something went wrong'], msg: [], isError: true);
         removeLoading=false;
         update();
       }
     }
     else{
       CustomSnackbar.showCustomSnackbar(errorList: [model.message], msg: [], isError: true);
       removeLoading=false;
       update();
     }

  }

}