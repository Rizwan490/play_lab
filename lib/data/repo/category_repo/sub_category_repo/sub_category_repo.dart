import '../../../../constants/method.dart';
import '../../../../core/utils/url_container.dart';
import '../../../services/api_service.dart';

class SubcategoryRepo{

  ApiClient apiClient;
  SubcategoryRepo({required this.apiClient});

  Future<dynamic>getSubCategory(int page,int subCategoryId)async{
    String url='${UrlContainer.baseUrl}${UrlContainer.subCategoryEndPoint}=$subCategoryId&page=$page';
    final response = await apiClient.request(url, Method.getMethod, null);
    return response;
  }




}