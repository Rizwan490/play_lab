import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/my_color.dart';
import '../../core/utils/dimensions.dart';
import '../../core/utils/styles.dart';


void showCustomSnackBar(String message, BuildContext context, {bool isError = true, bool text= false}) {
  Get.showSnackbar(GetSnackBar(
    messageText: Text(message, style: mulishSemiBold.copyWith(fontSize: Dimensions.fontSmall, color: MyColor.colorWhite),),
    backgroundColor: isError ? Colors.red : MyColor.greenSuccessColor,
    duration:const Duration(milliseconds: 3000),
    isDismissible: true,
    borderRadius: 10,
    margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeLarge),
    snackPosition: SnackPosition.BOTTOM,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      reverseAnimationCurve:  Curves.fastOutSlowIn));
}
