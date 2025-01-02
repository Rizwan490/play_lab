
import 'package:play_lab/constants/method.dart';
import 'package:play_lab/core/utils/url_container.dart';
import 'package:play_lab/data/services/api_service.dart';

class WishListRepo{

  ApiClient apiClient;
  WishListRepo({required this.apiClient});

  Future<dynamic>getWishList(int page)async{
    String url='${UrlContainer.baseUrl}${UrlContainer.wishlistEndPoint}?page=$page';
    final response=await apiClient.request(url, Method.getMethod, null,passHeader: true);
    return response;
  }

  Future<dynamic>removeFromWishlist(int itemId,int episodeId)async{
    String url = '${UrlContainer.baseUrl}${UrlContainer.removeFromWishlistEndPoint}episode_id=$episodeId&item_id=$itemId';
    final response=await apiClient.request(url, Method.postMethod, null,passHeader: true);
    return response;
  }

}