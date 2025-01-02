import 'dart:convert';
import 'package:get/get.dart';
import 'package:play_lab/data/model/category/sub_category_response_model.dart';
import 'package:play_lab/data/repo/category_repo/sub_category_repo/sub_category_repo.dart';
import '../../../model/global/response_model/response_model.dart';

class SubCategoryController extends GetxController {
  SubcategoryRepo repo;
  SubCategoryController({required this.repo, required this.categoryId});
  String? nextPageUrl;
  bool isLoading = true;
  List<Data> subCategoryList = [];
  int categoryId = -1;
  int selectedSubCategoryId = -1;
  int selectedSubCategoryIndex = -1;

  changeSelectedSubCategoryIndex(int index) {
    selectedSubCategoryIndex = index;
    selectedSubCategoryId = subCategoryList[selectedSubCategoryIndex].id ?? -1;
    update();
  }

  int page = 0;

  void fetchSubCategoryData(int categoryId) async {
    this.categoryId = categoryId;
    updateStatus(true);
    page = 1; //page+1;
    ResponseModel model = await repo.getSubCategory(page, categoryId);

    if (model.statusCode == 200) {
      print(model.statusCode);

      SubCategoryResponseModel subCategoryResponse = SubCategoryResponseModel.fromJson(jsonDecode(model.responseJson));
      List<Data>? tempSubCategoryList = subCategoryResponse.mainData?.subcategories?.data;
      nextPageUrl = subCategoryResponse.mainData?.subcategories?.nextPageUrl;
      if (tempSubCategoryList != null && !(tempSubCategoryList == [])) {
        if (page == 1) {
          subCategoryList.clear();
        }
        subCategoryList.addAll(tempSubCategoryList);
      }
      updateStatus(false);
    } else {
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

  void clearAllData() {
    page = 0;
    isLoading = true;
    nextPageUrl = null;
    selectedSubCategoryIndex = -1;
    categoryId = -1;
    subCategoryList.clear();
  }
}
