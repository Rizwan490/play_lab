
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:play_lab/constants/my_strings.dart';
import 'package:play_lab/core/route/route.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:play_lab/view/components/buttons/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/my_color.dart';


  showLoginDialog(BuildContext context,{bool fromDetails = false}){
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      dialogBackgroundColor: MyColor.otpBgColor,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
      buttonsBorderRadius: const BorderRadius.all(
        Radius.circular(2),
      ),
      dismissOnTouchOutside: true,
      dismissOnBackKeyPress: true,
      showCloseIcon: true,
      closeIcon: Container(
        padding: const EdgeInsets.all(5),
        decoration:  BoxDecoration(
            shape: BoxShape.circle,
            color: MyColor.colorGrey3.withOpacity(.1)
        ),
        child: const Icon(Icons.clear,size: 20,color: Colors.white,),
      ),
      onDismissCallback: (type) {},
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Text(MyStrings.plsLoginAndSubscribeToWatch.tr,textAlign:TextAlign.center,style:mulishRegular.copyWith(color: MyColor.colorWhite,fontSize: Dimensions.fontLarge),),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: RoundedButton(text:MyStrings.registerNow,vPadding: 11,hPadding:10,color: MyColor.highPriorityPurpleColor, press: (){
               Get.toNamed(RouteHelper.registrationScreen);
              })),const SizedBox(width: 10,),
              Expanded(child: RoundedButton(text: MyStrings.login,vPadding: 11,hPadding: 10, press: (){
                Get.toNamed(RouteHelper.loginScreen);
              },color: MyColor.primaryColor,))
            ],
          )
        ],
      ),
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
    ).show();
  }
