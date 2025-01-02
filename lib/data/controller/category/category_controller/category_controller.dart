
import 'dart:convert';
import 'package:get/get.dart';
import 'package:play_lab/data/model/category/category_response_model.dart';
import 'package:play_lab/data/model/global/response_model/response_model.dart';
import 'package:play_lab/data/repo/category_repo/category_repo/category_repo.dart';

class CategoryController extends GetxController{

     CategoryRepo repo;
     CategoryController({required this.repo});
     String? nextPageUrl;
     bool isLoading=true;
     List<Data>categoryList=[];

     int page = 0;

     void fetchInitialCategoryData() async {
       updateStatus(true);
       page =1;
       ResponseModel model =
       await repo.getCategory(page);

       if(model.statusCode==200)
       {

         CategoryResponseModel categoryResponse=CategoryResponseModel.fromJson(jsonDecode(model.responseJson));
         List<Data>?tempCategoryList=categoryResponse.data?.categories?.data;
         nextPageUrl=categoryResponse.data?.categories?.nextPageUrl;

         if(tempCategoryList !=null && !(tempCategoryList==[]) )
         {
           categoryList.clear();
           categoryList.addAll(tempCategoryList);
         }

         updateStatus(false);

       } else
       {
         updateStatus(false);
       }
     }
     void fetchCategoryData() async {
         updateStatus(true);
         page = page+1;
         ResponseModel model =
         await repo.getCategory(page);

         if(model.statusCode==200)
         {
           CategoryResponseModel categoryResponse=CategoryResponseModel.fromJson(jsonDecode(model.responseJson));
           List<Data>?tempCategoryList=categoryResponse.data?.categories?.data;
           nextPageUrl=categoryResponse.data?.categories?.nextPageUrl;

           if(tempCategoryList !=null && !(tempCategoryList==[]) ) {
              if(page==1){
               categoryList.clear();
             }
             categoryList.addAll(tempCategoryList);
           }
           updateStatus(false);
         } else
         {
           updateStatus(false);
         }
     }

     updateStatus(bool status) {
       isLoading = status;
       update();
     }

     bool hasNext() {
         return nextPageUrl != null ? true : false;
     }

}