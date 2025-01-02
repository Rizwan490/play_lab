
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../constants/my_strings.dart';
import '../../../view/components/show_custom_snackbar.dart';
import '../../repo/account/change_password_repo.dart';


class ChangePasswordController extends GetxController  {
  ChangePasswordRepo changePasswordRepo;

  ChangePasswordController({required this.changePasswordRepo});

  List<String> errors = [];
  String? currentPass, password, confirmPass;
  bool isLoading = false;
  TextEditingController currentPassController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  FocusNode currentPassFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPassFocusNode = FocusNode();



  addError({required String error}) {
    if (!errors.contains(error)) {
      errors.add(error);
      update();
    }
  }

  removeError({required String error}) {
    if (errors.contains(error)) {
      errors.remove(error);
      update();
    }
  }

  changePassword() async {
    String currentPass = currentPassController.text.toString();
    String password = passController.text.toString();

    if (errors.isEmpty) {

      if (currentPass.isEmpty) {
        addError(error: MyStrings.currentPassNullError);
        update();
        return;
      }

      if (password.isEmpty) {
        addError(error: MyStrings.currentPassNullError);
        update();
        return;
      }

      if (!(confirmPassController.text == passController.text)) {
        addError(error: MyStrings.kMatchPassError);
        update();
        return;
      }

      isLoading = true;
      update();
      bool b = await changePasswordRepo.changePassword(currentPass, password);

      if(b){
        currentPassController.clear();
        passController.clear();
        confirmPassController.clear();
      }

      isLoading = false;
      update();

    } else {
      CustomSnackbar.showCustomSnackbar(errorList: errors, msg: [], isError: true);
    }
  }

  void clearData() {
    isLoading = false;
    errors.clear();
    currentPassController.text = '';
    passController.text = '';
    confirmPassController.text = '';
  }

}
