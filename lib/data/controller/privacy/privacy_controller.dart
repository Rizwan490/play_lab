import 'dart:convert';
import 'package:get/get.dart';
import 'package:play_lab/data/model/global/response_model/response_model.dart';
import 'package:play_lab/view/components/show_custom_snackbar.dart';
import '../../model/about/privacy_response_model.dart';
import '../../repo/privacy_repo/privacy_repo.dart';

class PrivacyController extends GetxController {
  int selectedIndex = 1;
  PrivacyRepo repo;
  bool isLoading = true;

  List<PolicyPages> list = [];
  late var selectedHtml = '';

  PrivacyController({required this.repo});

  void loadData() async {
    list.clear();
    ResponseModel model = await repo.loadAboutData();
    if (model.statusCode == 200) {
      PrivacyResponseModel responseModel = PrivacyResponseModel.fromJson(jsonDecode(model.responseJson));
      if (responseModel.data?.policyPages?.isNotEmpty == true) {
        list.addAll(responseModel.data!.policyPages!);
        changeIndex(0);
        updateLoading(false);
      }
    } else {
      CustomSnackbar.showCustomSnackbar(errorList: [model.message], msg: [], isError: false);
      updateLoading(false);
    }
  }

  void changeIndex(int index) {
    selectedIndex = index;
    selectedHtml = list[index].dataValues?.description ?? '';
    update();
  }

  updateLoading(bool status) {
    isLoading = status;
    update();
  }
}
