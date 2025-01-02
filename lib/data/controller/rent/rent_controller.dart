import 'dart:convert';

import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/data/model/global/response_model/response_model.dart';
import 'package:play_lab/data/model/rent/rent_response_model.dart';
import 'package:play_lab/data/repo/rent/rent_repo.dart';
import 'package:play_lab/view/components/show_custom_snackbar.dart';

class RentController extends GetxController {
  RentRepo repo;
  RentController({required this.repo});

  bool isLoading = false;

  void initialValue() {
    isLoading = true;
    page = 0;
    update();
    getRentedVideoList();
  }

  List<RentVideo> items = [];

  int page = 0;
  String? nextPageUrl;
  String landScapePath = '';
  String path = '';

  void getRentedVideoList() async {
    page = page + 1;
    if (page == 1) {
      items.clear();
      isLoading = true;
      update();
    }
    try {
      ResponseModel responseModel = await repo.getRentHistory(page.toString());
      if (responseModel.statusCode == 200) {
        RentedItemsResponseModel model = RentedItemsResponseModel.fromJson(jsonDecode(responseModel.responseJson));
        if (model.status!.toLowerCase() == MyStrings.success.toLowerCase()) {
          path = model.data?.portRaitPath ?? '';
          landScapePath = model.data?.landScapePath ?? '';
          nextPageUrl = model.data?.rentedItems?.nextPageUrl;

          List<RentVideo>? tempList = model.data?.rentedItems?.data;
          if (tempList != null && tempList.isNotEmpty) {
            items.addAll(tempList);
          }
        } else {
          CustomSnackbar.showCustomSnackbar(errorList: model.message?.error ?? [MyStrings.somethingWentWrong], msg: [], isError: true);
        }
      } else {
        CustomSnackbar.showCustomSnackbar(errorList: [responseModel.message], msg: [], isError: true);
      }
    } catch (e) {
      CustomSnackbar.showCustomSnackbar(errorList: [e.toString()], msg: [], isError: true);
      print(e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  bool hasNext() {
    return nextPageUrl != null && nextPageUrl!.isNotEmpty && nextPageUrl != 'null' ? true : false;
  }
}
