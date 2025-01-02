import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../constants/my_strings.dart';
import '../../../../core/route/route.dart';
import '../../../../view/components/show_custom_snackbar.dart';
import '../../../model/auth/verification/email_verification_model.dart';
import '../../../repo/auth/login_repo.dart';

class ForgetPasswordController extends GetxController {
  LoginRepo loginRepo;


  List<String> errors = [];
  String email='';
  String password='';
  String confirmPassword='';
  bool isLoading = false;
  bool remember = false;
  bool hasError = false;
  String currentText = "";


  ForgetPasswordController({required this.loginRepo});

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

  void submitForgetPassCode() async {
    if (errors.isNotEmpty) {
    }
    if(email.isEmpty){
      addError(error: MyStrings.kEmailNullError);
      return;
    }
    if(email.isNotEmpty){
      removeError(error: MyStrings.kEmailNullError);

    }

      isLoading = true;
      update();
      String value = email;
      String type = value.contains('@') ? 'email' : 'username';
      String responseEmail = await loginRepo.forgetPassword(type, value);
      if(responseEmail.isNotEmpty){
        Get.toNamed(RouteHelper.verifyPassCodeScreen,arguments: responseEmail);
      }else{

      }
      isLoading = false;
      update();

  }

  bool isResendLoading=false;
  void resendForgetPassCode() async {
    isResendLoading=true;
    update();
    String value = email;
    String type = 'email';
    await loginRepo.forgetPassword(type, value);
    isResendLoading=false;
    update();

  }

  void verifyForgetPasswordCode(String value) async{

       if(value.isNotEmpty){
         isLoading=true;
         update();
        EmailVerificationModel model= await loginRepo.verifyForgetPassCode(value);
        if(model.status=='success'){
          isLoading=false;
          Get.offAndToNamed(RouteHelper.resetPasswordScreen,arguments: email);
          clearAllData();
        }else{
          isLoading=false;
          update();
          List<String>errorList=[MyStrings.verificationFailed];
          CustomSnackbar.showCustomSnackbar(errorList: model.message?.error??errorList, msg: [], isError: true);
        }
       }
  }

  bool checkPasswordStrength = false;

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();

  RegExp regex =
  RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  bool isValidPassword(String value) {
    if (value.isEmpty) {
      return false;
    } else {
      if (checkPasswordStrength) {
        if (!regex.hasMatch(value)) {
          return false;
        } else {
          return true;
        }
      } else {
        return true;
      }
    }
  }


  void resetPassword() async {

       if(errors.isEmpty&&password.isNotEmpty&&email.isNotEmpty){
         isLoading=true;
         update();
        EmailVerificationModel model= await loginRepo.resetPassword(email,password);
        isLoading=false;
        update();
        if(model.code==200){
         Get.offAndToNamed(RouteHelper.loginScreen);
        }

       }
  }

  clearAllData(){
    isLoading=false;
    currentText='';
  }

}
