
import 'dart:async';
import 'package:get/get.dart';
import '../../../../core/route/route.dart';
import '../../../../view/components/show_custom_snackbar.dart';
import '../../../repo/auth/sms_email_verification_repo.dart';

class SmsVerificationController extends GetxController{

      SmsEmailVerificationRepo repo;
      SmsVerificationController({required this.repo});

      bool isProfileCompleteEnable=false;
      String currentText = "";
      bool isLoading=false;

     Future<bool> loadBefore()async{
        await repo.sendAuthorizationRequest();
        return true;
      }

    bool submitLoading = false;
    verifyYourSms()async{

       if(currentText.isEmpty){
         return;
       }

       submitLoading = true;
       update();
       bool  isSuccess= await repo.verify(currentText.toString(),isEmail: false,isTFA: false);
       if(isSuccess){
          CustomSnackbar.showCustomSnackbar(errorList: [], msg: [], isError: false);
          Get.offAndToNamed(isProfileCompleteEnable? RouteHelper.profileComplete:RouteHelper.homeScreen);
       }
       submitLoading = false;
       update();
      }

      bool resendLoading = false;
      Future<void> sendCodeAgain() async {
        resendLoading = true;
        update();
        await repo.resendVerifyCode(isEmail: false);
        resendLoading = false;
        update();
      }

      clearData(){
        isLoading=false;
      }

}