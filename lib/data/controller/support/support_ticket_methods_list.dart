import 'package:get/get.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/view/components/show_custom_snackbar.dart';
import '../../model/global/response_model/response_model.dart';
import '../../model/support/community_group_model.dart';
import '../../model/support/support_methods_model.dart';
import '../../repo/support/support_repo.dart';

class SupportTicketMethodsController extends GetxController {
  SupportRepo repo;
  SupportTicketMethodsController({required this.repo});

  bool isLoading = false;
  String methodFilePath = "";
  List<SupportMethod> supportMethodsList = [];

  Future<void> getSupportMethodsList() async {
    isLoading = true;
    update();
    try {
      ResponseModel responseModel = await repo.getSupportMethodsList();
      if (responseModel.statusCode == 200) {
        supportMethodsList.clear();
        SupportMethods model = supportMethodsFromJson(responseModel.responseJson);
        if (model.status == MyStrings.success) {
          methodFilePath = model.data!.methodFilePath ?? '';
          List<SupportMethod>? tempList = model.data?.methods;

          if (tempList != null && tempList.isNotEmpty) {
            supportMethodsList.addAll(tempList);
          }
        } else {
          CustomSnackbar.showCustomSnackbar(errorList: [MyStrings.somethingWentWrong], isError: true, msg: []);
        }
      } else {
        CustomSnackbar.showCustomSnackbar(errorList: [responseModel.message], isError: true, msg: []);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  String communityGroupImagePath = "";
  List<CommunityGroupElement> getCommunityGroupList = [];

}
