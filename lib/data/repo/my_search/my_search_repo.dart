
import 'package:play_lab/data/services/api_service.dart';

import '../../../constants/method.dart';
import '../../../core/utils/url_container.dart';

class MySearchRepo{
  ApiClient apiClient;
  MySearchRepo({required this.apiClient});

  Future<dynamic>getMovie({required int page,String searchText='',int categoryId=-1, int subCategoryId=-1})async{
    String url='';
    if(categoryId!=-1 && subCategoryId !=-1){
      url='${UrlContainer.baseUrl}${UrlContainer.searchEndPoint}=$page&search=$searchText&category_id=$categoryId&subcategory_id=$subCategoryId';
    }else if(categoryId !=-1){
      url='${UrlContainer.baseUrl}${UrlContainer.searchEndPoint}=$page&search=$searchText&category_id=$categoryId&subcategory_id=';
    }else if(subCategoryId!=-1){
      url='${UrlContainer.baseUrl}${UrlContainer.searchEndPoint}=$page&search=$searchText&category_id=&subcategory_id=$subCategoryId';
    }else{
      url='${UrlContainer.baseUrl}${UrlContainer.searchEndPoint}=$page&search=$searchText&category_id=&subcategory_id=';
    }
    final response = await apiClient.request(url, Method.getMethod, null);
    return response;
  }


}