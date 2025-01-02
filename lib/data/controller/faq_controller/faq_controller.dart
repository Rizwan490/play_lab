import 'dart:convert';
import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/data/model/faq/faq_response_model.dart';
import 'package:play_lab/data/model/global/response_model/response_model.dart';
import 'package:play_lab/data/repo/faq_repo/faq_repo.dart';
import 'package:play_lab/view/components/show_custom_snackbar.dart';

class FaqController extends GetxController {
  FaqRepo faqRepo;
  FaqController({required this.faqRepo});

  bool isLoading = true;
  bool isPress = false;
  int selectedIndex = -1;

  List<Faqs> faqList = [];

  void changeSelectedIndex(int index) {
    if (selectedIndex == index) {
      selectedIndex = -1;
      update();
      return;
    }
    selectedIndex = index;
    update();
  }

  void loadData() async {
    ResponseModel model = await faqRepo.loadFaq();
    if (model.statusCode == 200) {
      FaqResponseModel responseModel = FaqResponseModel.fromJson(jsonDecode(model.responseJson));
      if (responseModel.status.toString() == "success") {
        List<Faqs>? tempFaqList = responseModel.data?.faqs;
        if (tempFaqList != null && tempFaqList.isNotEmpty) {
          faqList.addAll(tempFaqList);
        }
      } else {
        CustomSnackbar.showCustomSnackbar(errorList: responseModel.message?.error ?? [MyStrings.somethingWentWrong], msg: [], isError: true);
      }
    } else {
      CustomSnackbar.showCustomSnackbar(errorList: [model.message], msg: [], isError: true);
    }
    isLoading = false;
    update();
  }
}
